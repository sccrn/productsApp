//
//  RealmManager.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

///Our Realm's class with all the methods that we're gonna need, so we don't need to import in every
///class the RealmSwift.
class RealmManager {
    let realm = try? Realm()
    
    func saveObjects(objts: [Object]) {
        try? realm!.write ({
            realm?.add(objts, update: false)
        })
    }
    
    func saveObject(objt: Object) {
        try? realm!.write ({
            realm?.add(objt, update: false)
        })
    }
    
    func editCart(quantity: Int, objt: CartRealm) {
        try? realm!.write ({
            objt.productsQuantity = quantity
            realm?.add(objt, update: true)
        })
    }
    
    func deleteProducts() {
        let products = getProducts()
        try? realm!.write ({
            realm?.delete(products)
        })
    }
    
    func deleteCart(by cart: CartRealm) {
        try? realm!.write ({
            realm?.delete(cart)
        })
    }
    
    func getCartObject() -> CartRealm? {
        let obj = realm!.objects(CartRealm.self)
        return obj.first
    }

    func getProducts() -> [ProductRealm] {
        let result = realm!.objects(ProductRealm.self)
        return result.compactMap { $0 }
    }
}
