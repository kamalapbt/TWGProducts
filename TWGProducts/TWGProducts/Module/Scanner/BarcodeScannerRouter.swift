//
//  ProductDetailRouter.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 29/09/21.
//

import UIKit

class BarcodeScannerRouter: Routerable {
    
    weak var entry: BarcodeScannerViewController?
    
    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "vcBarcodeScanner") as! BarcodeScannerViewController
        
        let interactor: BarcodeScannerInteractor = BarcodeScannerInteractor()
        let presenter: BarcodeScannerPresenter = BarcodeScannerPresenter()
        
        view.presenter = presenter

        interactor.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
        self.entry = view
    }
    
    func presentDetail(forBarcode item: Product) {
        guard let entryView = self.entry else {
            print("BarcodeScannerRouter view is not set")
            return
        }
        guard let detailRouter = ProductDetailRouter(withEntity: item).entry else {
            print("ProductDetailRouterRoot viewcontroller is not set")
            return
        }
        entryView.navigationController?.pushViewController(detailRouter, animated: true)
    }
    
    func showAlert(for error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.entry?.present(alert, animated: true, completion: nil)
    }
    
    func close() {
        self.entry?.dismiss(animated: true, completion: nil)
    }
}
