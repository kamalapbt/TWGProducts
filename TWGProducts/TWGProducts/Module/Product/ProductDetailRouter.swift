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

        interactor.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor
        self.entry = view
    }
}
