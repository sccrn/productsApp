//
//  Products.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let code: String
    let name: String
    let price: Double
}
