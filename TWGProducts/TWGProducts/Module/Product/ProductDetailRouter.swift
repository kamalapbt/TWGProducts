//
//  ProductDetailRouter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 1/10/21.
//

import UIKit

class ProductDetailRouter: Routerable {
    
    weak var entry: ProductDetailViewController?
    
    init(withEntity data: Product) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "vcProductDetail") as! ProductDetailViewController
        
        let interactor: ProductDetailInteractor = ProductDetailInteractor()
        let presenter: ProductDetailPresenter = ProductDetailPresenter(withEntity: data)
        
        view.presenter = presenter

        interactor.output = presenter

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
        self.entry = view
    }
    
    func showAlert(for error: Error) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.entry?.present(alert, animated: true, completion: nil)
    }
}
