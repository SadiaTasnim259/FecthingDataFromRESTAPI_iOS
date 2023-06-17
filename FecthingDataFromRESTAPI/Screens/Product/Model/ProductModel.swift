//
//  ProductModel.swift
//  FecthingDataFromRESTAPI
//
//  Created by Sadia on 16/6/23.
//

import Foundation

struct ProductModel: Decodable{
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rate
}

struct Rate: Decodable{
    let rate: Double
    let count: Int
}
