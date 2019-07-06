//
//  Discount.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

enum Discount {
    case voucher(product: ProductRealm)
    case tshirt(product: ProductRealm, newPrice: Double)
    case mug(product: ProductRealm)
    
    var codeName: String {
        switch self {
        case .voucher: return Constants.Discount.voucher
        case .tshirt: return Constants.Discount.tshirt
        case .mug: return Constants.Discount.mug
        }
    }

    var description: String {
        switch self {
        case .voucher(let product): return "Buy two \(product.name), get one free"
        case .tshirt(let product, let newPrice):
            return "Buy 3 or more \(product.name), pay \(newPrice)€ per unit"
        case .mug: return ""
        }
    }
    
    var discountPrice: Double {
        switch self {
        case .voucher(let product):
            let isPairQuantity = product.quantity % 2 == 0
            let quantity: Int = product.quantity % 2
            return isPairQuantity ? (Double(quantity) * product.price) : (product.quantity == 1 ? product.price : ((Double(quantity) * product.price) + product.price))
        case .tshirt(let product, let newPrice):
            let price = product.quantity >= 3 ? newPrice : product.price
            return Double(product.quantity) * price
        case .mug(let product): return Double(product.quantity) * product.price
        }
    }
}
