//
//  ProductViewModel.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import Foundation

final class ProductViewModel{
    
    var addProductViewController = AddProductViewController()
    var products:[ProductModel] = [] // product model er array hobe jeta pabo
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    func FetchProducts() {
        self.eventHandler?(.loading)
        
        NetworkManager.shared.httpRequest(urlString: Constant.API.GET_ALL_PRODUCTS, httpMethodType: .GET, respnseType: [ProductModel].self) { result in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch result {
                case .success(let success):
                        self.products = success
                        self.eventHandler?(.dataLoaded)
                case .failure(let failure):
                    self.eventHandler?(.error(failure))
                }
            }
            
        }
    }
}

// MARK: - Event

extension ProductViewModel{
    enum Event{
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}


// MARK: - POST product

extension ProductViewModel{
    func addProduct(parameters: AddProduct){
        var params:[String:Any] = [:]
        params["title"] = parameters.title
        
        NetworkManager.shared.httpRequest(urlString: Constant.API.POST_ADD_PRODUCT, httpMethodType: .POST(params: params), respnseType: ProductResponse.self) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
