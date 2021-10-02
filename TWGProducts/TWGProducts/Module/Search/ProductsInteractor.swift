//
//  ProductsInteractor.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import Foundation

class ProductsInteractor: Interactorable {
    weak var output: ProductsPresenter?
    func searchProducts(forText text: String) {
        URLSession.shared.request(.search(for: text), type: SearchResult.self) { items in
            self.output?.didRecieveData(with: items)
        }
    }
}
