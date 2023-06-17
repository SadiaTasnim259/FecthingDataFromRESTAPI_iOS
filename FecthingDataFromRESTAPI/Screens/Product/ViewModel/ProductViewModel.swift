//
//  ProductViewModel.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import Foundation

final class ProductViewModel{
    
    var products:[ProductModel] = [] // product model er array hobe jeta pabo
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    func FetchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response{
            case.success(let products):
                 self.products = products  //api theke je product ami pacchi sob ami uporer products ke diye dilm karon vc te to kichu hobe na
                self.eventHandler?(.dataLoaded)
            case.failure(let error):
                self.eventHandler?(.error(error))
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
