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
    
    var codeName: String {
        switch self {
        case .voucher: return Constants.Discount.voucher
        case .tshirt: return Constants.Discount.tshirt
        }
    }

    var description: String {
        switch self {
        case .voucher: return Constants.Discount.voucherDescription
        case .tshirt(let product, let newPrice):
            return "Buy 3 or more \(product.name), pay \(newPrice)€ per unit"
        }
    }
    
    var discountPrice: Double {
        switch self {
        case .voucher(let product):
            let oneFreeProduct = Double(product.quantity) * product.price/2
            let isPairQuantity = product.quantity % 2 == 0
            return isPairQuantity ? oneFreeProduct : (product.quantity == 1 ? product.price : (oneFreeProduct + product.price))
        case .tshirt(let product, let newPrice):
            let price = product.quantity >= 3 ? newPrice : product.price
            return Double(product.quantity) * price
        }
    }
}
