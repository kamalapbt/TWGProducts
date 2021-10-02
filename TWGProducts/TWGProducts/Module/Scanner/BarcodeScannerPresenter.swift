//
//  ProductDetailPresenter.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 29/09/21.
//

import Foundation

enum CameraError: Error {
    case noCamera
    case noPermissionGranted
    case permissionRequired
}
extension CameraError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noCamera:
            return NSLocalizedString("There seems to be no camera on the running device. ", comment: "No Camera")
        case .noPermissionGranted:
            return NSLocalizedString("No premission granted to access to the camera for scanning barcodes.", comment: "No permission for the camera")
        case .permissionRequired:
            return NSLocalizedString("Please grant access to the camera for scanning barcodes.", comment: "Permission required")
        }
    }
}

enum BarcodeError: Error {
    case noValidData
    case unKnown
}
extension BarcodeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noValidData:
            return NSLocalizedString("Cannot extract barcode information from data.", comment: "No valid data")
        case .unKnown:
            return NSLocalizedString("Unknown error.", comment: "Unknown error")
        }
    }
}

class BarcodeScannerPresenter: Presenterable {
    var router: BarcodeScannerRouter?
    var interactor: BarcodeScannerInteractor?
    weak var view: BarcodeScannerViewController?
    
    func recieveBarcode(withPayload data: String) {
        let selectedEntity = Product(withBarcode: data, description: nil, imageUrl: nil, price: nil)
        self.didRecieveData(with: .success(selectedEntity))
    }
    func didRecieveData(with data: Result<Product, Error>) {
        switch data {
        case .success(let data):
            router!.presentDetail(forBarcode: data)
        case .failure(let error):
        self.router?.showAlert(for: error)
        }
    }
    
    func closeScanner() {
        self.router?.close()
    }
    
    
}
