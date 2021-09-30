//
//  ViewController.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import UIKit

class ProductsViewController: UIViewController, Viewable {
    var presenter: ProductsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    func didRecieveData(with data: SearchResult) {
        
    }
    func didRecieveError(with error: Error) {
        
    }

}

