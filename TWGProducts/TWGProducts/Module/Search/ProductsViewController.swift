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
    
    func didRecieveData(with data: SearchResult?) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didRecieveError(with error: Error) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ProductsViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.onSearchProducts(forText: searchBar.text)
        searchBar.endEditing(true)
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.searchResult?.result?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        cell.textLabel?.text = self.presenter?.searchResult?.result?[indexPath.row].description
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let resultItem =  self.presenter?.searchResult?.result?[indexPath.row] else {
            return
        }
        self.presenter?.onSelectProduct(withItem: resultItem)
    }
}
