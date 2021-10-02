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
        let detailRouter: ProductDetailRouter = ProductDetailRouter(withEntity: item)
        entry!.navigationController?.pushViewController(detailRouter.entry!, animated: true)
    }
    
    func presentBarcodeScanner() {
        let barcodeScannerRouter: BarcodeScannerRouter = BarcodeScannerRouter()
        let nav = UINavigationController(rootViewController: barcodeScannerRouter.entry!)
        entry!.present(nav, animated: true, completion: nil)
    }
}
