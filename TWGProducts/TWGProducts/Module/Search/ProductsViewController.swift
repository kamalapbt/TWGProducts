//
//  ViewController.swift
//  TWGProducts
//
//  Created by Kamala Tennakoon on 30/09/21.
//

import UIKit

class ProductsViewController: UIViewController, Viewable {
    @IBOutlet weak var tableView: UITableView!
    var presenter: ProductsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func onTapBarcodeScanner(_ sender: Any) {
        
    }
    
    func didRecieveData(with data: SearchResult) {

    }
    
    func didRecieveError(with error: Error) {
        
    }
    
    
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        cell.textLabel?.text = "Dummy text \(indexPath.row)"
        return cell
    }
}
