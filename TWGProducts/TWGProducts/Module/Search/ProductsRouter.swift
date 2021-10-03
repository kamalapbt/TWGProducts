//
//  ProductsRouter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import UIKit

class ProductsRouter: Routerable {
    var entry: ProductsViewController?
    
    init() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "vcProducts") as! ProductsViewController
        let interactor: ProductsInteractor = ProductsInteractor()
        let presenter: ProductsPresenter = ProductsPresenter()

        view.presenter = presenter

        interactor.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
    
        self.entry = view
    }
    
    func presentDetail(forEntity item: Product) {
        guard let entryView = entry else {
            print("ProductsRouter view is not set")
            return
        }
        guard let detailRouter = ProductDetailRouter(withEntity: item).entry else {
            print("ProductDetailRouter view is not set")
            return
        }
        entryView.navigationController?.pushViewController(detailRouter, animated: true)
    }
    
    func presentBarcodeScanner() {
        guard let entryView = entry else {
            print("ProductsRouter view is not set")
            return
        }
        guard let barcodeScannerView = BarcodeScannerRouter().entry else {
            print("BarcodeScannerRouter view is not set")
            return
        }
        let nav = UINavigationController(rootViewController: barcodeScannerView)
        entryView.present(nav, animated: true, completion: nil)
    }
}
