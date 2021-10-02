//
//  BarcodeScannerViewController.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import UIKit
import Vision
import AVFoundation

class BarcodeScannerViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var presenter: BarcodeScannerPresenter?
    var captureSession: AVCaptureSession!
    var backCamera: AVCaptureDevice?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var captureOutput: AVCapturePhotoOutput?
    var shutterButton: UIButton!
    
    @IBOutlet weak var cameraView: UIView!
    
    var layerCamer: CALayer {
        return cameraView.layer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
    }
    func didRecieveError(with error: Error) {
        
    }
    
    func didRecieveData(with data: Any) {
        
    }
    
    @objc func back() {
        self.presenter?.closeScanner()
    }
    
    
    lazy var detectBarcodeRequest: VNDetectBarcodesRequest = {
        return VNDetectBarcodesRequest(completionHandler: { (request, error) in
            guard error == nil else {
                let requestError = error ?? BarcodeError.unKnown
                self.presenter?.didRecieveData(with: .failure(requestError))
                return
            }
            self.processClassification(for: request)
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermissions()
        setupCameraLiveView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkPermissions()
    }
    
    private func checkPermissions() {
        let mediaType = AVMediaType.video
        let status = AVCaptureDevice.authorizationStatus(for: mediaType)
        
        switch status {
        case .denied, .restricted:
            self.presenter?.didRecieveData(with: .failure(CameraError.noPermissionGranted))
        case.notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                guard granted != true else { return }
                DispatchQueue.main.async {
                    self.presenter?.didRecieveData(with: .failure(CameraError.permissionRequired))
                }
            }
        default: break
        }
    }
    
    private func setupCameraLiveView() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            }
        }

        guard let backCamera = backCamera else {
            self.presenter?.didRecieveData(with: .failure(CameraError.noCamera))
            return
        }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(captureDeviceInput)
        } catch {
            self.presenter?.didRecieveData(with: .failure(error))
            return
        }
        
        
        // Initialize the capture output and add it to the session.
        captureOutput = AVCapturePhotoOutput()
        captureOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        
        captureSession.addOutput(captureOutput!)
        
        // Add a preview layer.
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer!.videoGravity = .resizeAspectFill
        cameraPreviewLayer!.connection?.videoOrientation = .portrait
        
        layerCamer.addSublayer(cameraPreviewLayer!)
        captureSession.startRunning()
    }
    
    @IBAction func captureBarcode(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        captureOutput?.capturePhoto(with: settings, delegate: self)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraPreviewLayer?.frame = layerCamer.bounds;
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            
            guard let ciImage = CIImage(image: image) else {
                fatalError("Unable to create \(CIImage.self) from \(image).")
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(ciImage: ciImage, orientation: CGImagePropertyOrientation.up, options: [:])
                do {
                    try handler.perform([self.detectBarcodeRequest])
                } catch {
                    self.presenter?.didRecieveData(with: .failure(error))
                }
            }
        }
    }
    
    func processClassification(for request: VNRequest) {
        DispatchQueue.main.async {
            if let bestResult = request.results?.first as? VNBarcodeObservation, let payload = bestResult.payloadStringValue {
                self.presenter?.recieveBarcode(withPayload: payload)
            } else {
                self.presenter?.didRecieveData(with: .failure(BarcodeError.noValidData))
            }
        }
    }
}
