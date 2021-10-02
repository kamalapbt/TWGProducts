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
    var searchResult: SearchResult?
    
    func onSearchProducts(forText text: String?) {
        interactor?.searchProducts(forText: text!)
    }
    
    func didRecieveData(with data: Result<SearchResult, Error>) {
        switch data {
        case .success(let data):
            searchResult = data
            view?.didRecieveData(with: data)
        case .failure(let error):
            searchResult = nil
            view?.didRecieveError(with:error)
        }
    }
    
    func onSelectProduct(withItem item: Item) {
        let selectedEntity = Product(withBarcode: item.products!.first!.barcode, description: item.description, imageUrl: item.products?.first?.imageUrl ?? nil, price: nil)
        router!.presentDetail(forEntity: selectedEntity)
    }
    
    func showScanner() {
        router!.presentBarcodeScanner()
    }
}
