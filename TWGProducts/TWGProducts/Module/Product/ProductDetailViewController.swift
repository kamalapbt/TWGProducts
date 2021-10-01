//
//  ProductDetailViewController.swift
//  The Warehouse Test
//
//  Created by Kamala Tennakoon on 1/10/21.
//

import UIKit

class ProductDetailViewController: UIViewController, Viewable {
    
    var presenter: ProductDetailPresenter?
    @IBOutlet var imageProduct: UIImageView!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelBarcode: UILabel!
    @IBOutlet var labelPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getProductDetail()
        setViewProductDetails()
    }
    
    
    func didRecieveError(with error: Error) {
        DispatchQueue.main.async() { [weak self] in
            let alert = UIAlertController(title: "Sorry cannot get the data.", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }

    }
    
    func didRecieveData(with data: Any) {
        if data is Product{
            setViewProductDetails()
        } else if let resource = data as? Resource {
            guard let imageData = resource.data, resource.mode == Mode.image else {
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.imageProduct.image = UIImage(data: imageData)
            }
            
        }
    }
    
    func setViewProductDetails() {
        self.labelDescription.text = self.presenter?.product.description ?? ""
        self.labelBarcode.text = self.presenter?.product.barcode ?? ""
        self.labelPrice.text = self.presenter?.product.price ?? ""
        if let imageUrl = self.presenter?.product.imageUrl {
            self.presenter?.loadImage(fromUrl: imageUrl)
        }
    }

}
