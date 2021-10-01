//
//  ProductDetailInteractor.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 1/10/21.
//

import Foundation

class ProductDetailInteractor: Interactorable {
    weak var presenter: ProductDetailPresenter?
    
    func fetchProductDetail(forBarcode text: String) {
        URLSession.shared.request(.product(withBarcode: text), type: Product.self) { data in
            self.presenter?.didRecieveData(with: data)
        }
    }
    
    func downloadImage(from url: String) {
        URLSession.shared.getResourse(fromUrl: URL(string: url)!, mode: Mode.image) { data in
            self.presenter?.didLoadResource(with: data)
        }
    }
    
}
