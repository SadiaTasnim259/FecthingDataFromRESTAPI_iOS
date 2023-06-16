//
//  APIManager.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import Foundation

enum DataError: Error{
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

final class APIManager{
    static let shared = APIManager()
    private init(){}
    
    typealias Handler =  (Result<[ProductModel], DataError>) -> Void
    
    func fetchProducts(completion: @escaping Handler){
        guard let url = URL(string: Constant.API.productURL) else {  // URL string hisebe pacchi setake url e convert korlm
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let products = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(products))
            }catch{
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}
