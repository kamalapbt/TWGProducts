//
//  ProductsPresenter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import Foundation

class ProductsPresenter: Presenterable {
    var router: ProductsRouter?
    var interactor: ProductsInteractor?
    weak var view: ProductsViewController?
    
    func didRecieveData(with result: Result<SearchResult, Error>) {
        
    }
}
