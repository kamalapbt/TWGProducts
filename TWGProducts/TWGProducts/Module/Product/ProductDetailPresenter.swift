//
//  ProductDetailPresenter.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 1/10/21.
//
import Foundation

extension Presenterable {
    func didLoadResource(with data: Result<Resource, Error>) {}
}
class ProductDetailPresenter: Presenterable {
    var router: ProductDetailRouter?
    var interactor: ProductDetailInteractor?
    weak var view: ProductDetailViewController?
    var product: Product
    
    
    init(withEntity entity: Product) {
        product = entity
    }
    
    func didRecieveData(with data: Result<Product, Error>) {
        switch data {
            case .success(let data):
                view?.didRecieveData(with: data)
                break
            case .failure(let error):
                view?.didRecieveError(with:error)
        }
    }
    
    func getProductDetail() {
        interactor?.fetchProductDetail(forBarcode: product.barcode)
    }
    
    func loadImage(fromUrl text: String) {
//        if let urlText = text {
            interactor?.downloadImage(from: text)
//        }
    }
    
    func finishedImageDownload(withData data: Data) {
        view?.didRecieveData(with: data)
    }

    func didLoadResource(with data: Result<Resource, Error>) {
        switch data {
            case .success(let data):
                view?.didRecieveData(with: data)
                break
            case .failure(let error):
                view?.didRecieveError(with:error)
        }
    }
}
