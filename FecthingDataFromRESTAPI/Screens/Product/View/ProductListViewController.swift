//
//  ProductListViewController.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    private var productViewModel = ProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        configuration()
        
        tableView.register(UINib(nibName: "productListViewCell", bundle: nil), forCellReuseIdentifier: "productListViewCell")
    }

}

extension ProductListViewController{
    func configuration(){
        initViewModel()
        observeEvent()
    }
    
    func initViewModel(){
        productViewModel.FetchProducts()
    }
    
    func observeEvent(){
        productViewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event{
            case .loading:
                print("Product loading..")
            case .stopLoading:
                print("Stop loading..")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.tableView.reloadData() //UI main e work kore
                }
                //print(self.productViewModel.products)
            case .error(let error):
                print(error)
            }
        }
    }
}

// MARK: - TableView

extension ProductListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productListViewCell") as? productListViewCell else{
            return UITableViewCell()
        }
        let product = productViewModel.products[indexPath.row]
        cell.productDetailConfiguration(product: product)
        return cell
        
    }
    
    
}
