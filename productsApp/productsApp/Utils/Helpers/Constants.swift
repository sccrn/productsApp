//
//  Constants.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

struct Constants {
    struct Service {
        static let baseURL = "https://api.myjson.com/"
        static let productsPath = "bins/4bwec"
        static let acceptType = "Accept"
        static let contentType = "Content-Type"
        static let acceptEnconding = "Accept-Enconding"
        static let json = "application/json"
    }
    
    struct Realm {
        static let primaryKey = "currentCart"
    }
    
    struct Screen {
        static let home = "Products"
        static let checkout = "Check out"
    }
    
    struct Label {
        static let productsQuantity = "Products quantity: "
        static let totalPrice = "Total: "
        static let price = "€"
        static let sectionTitle = "Hello! Choose your products! :)"
    }
    
    struct Discount {
        static let voucher = "VOUCHER"
        static let tshirt = "TSHIRT"
        
        static let voucherDescription = "Buy two, get one free"
    }
    
    struct Error {
        static let ok = "Ok!"
        static let ops = "Ops!"
        static let zeroProducts = "Sorry, you must add at least one product to your cart!"
    }
}
