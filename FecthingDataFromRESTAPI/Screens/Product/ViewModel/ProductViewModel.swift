//
//  ProductViewModel.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import Foundation

final class ProductViewModel{
    
    var products:[ProductModel] = [] // product model er array hobe jeta pabo
    
    func FetchProducts(){
        APIManager.shared.fetchProducts { response in
            switch response{
            case.success(let products):
                //self.products = products  //api theke je product ami pacchi sob ami uporer products ke diye dilm karon vc te to kichu hobe na
                print(products)
            case.failure(let error):
                print(error)
            }
        }
    }
}
