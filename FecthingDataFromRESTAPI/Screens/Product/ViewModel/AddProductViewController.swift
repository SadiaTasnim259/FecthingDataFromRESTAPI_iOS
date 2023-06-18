//
//  AddProductViewController.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 17/6/23.
//

import UIKit

struct AddProduct:Encodable {
    let title:String
}

struct ProductResponse:Decodable{
    let id: Int
    let title: String
}

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProduct()
        // Do any additional setup after loading the view.
    }
    
    func  addProduct(){
        guard let url = URL(string: "https://dummyjson.com/products/add") else {return}
        
        let parameters = AddProduct(title: "BMW Car ")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //model to data
        request.httpBody = try? JSONEncoder().encode(parameters)
        
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else {return}
            
            do{
                //data to model convert
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                print(productResponse)
            }catch{
                print(error)
            }
        }.resume()
    }


}
