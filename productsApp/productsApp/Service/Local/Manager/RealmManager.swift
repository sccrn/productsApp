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
        try? realm?.write ({
            realm?.add(objts, update: false)
        })
    }
    
    func saveObject(objt: Object) {
        try? realm?.write ({
            realm?.add(objt, update: false)
        })
    }
    
    func editCart(objt: CartRealm, product: Product, isAddProduct: Bool) {
        try? realm?.write ({
            var containsProduct = false
            for (index, prod) in objt.products.enumerated() where prod.name == product.name {
                containsProduct = true
                prod.quantity = isAddProduct ? prod.quantity + 1 : prod.quantity - 1
                objt.productsQuantity = isAddProduct ? objt.productsQuantity + 1 : objt.productsQuantity - 1
                if prod.quantity > 0 {
                    realm?.add(prod, update: true)
                } else {
                    objt.products.remove(at: index)
                    realm?.delete(prod)
                }
                break
            }
            if !containsProduct && isAddProduct {
                let model = ProductRealm()
                model.code = product.code
                model.name = product.name
                model.price = product.price
                model.quantity = 1
                
                realm?.add(model, update: false)
                objt.productsQuantity += 1
                objt.products.append(model)
            }
            realm?.add(objt, update: true)
        })
    }
    
    func editCartTotalPrice(cart: CartRealm, total: Double) {
        try? realm?.write ({
            cart.price = total
            realm?.add(cart, update: false)
        })
    }
    
    func deleteProducts() {
        let products = getProducts()
        try? realm?.write ({
            realm?.delete(products)
        })
    }
    
    func deleteCart(by cart: CartRealm) {
        try? realm?.write ({
            realm?.delete(cart)
        })
    }
    
    func getCartObject() -> CartRealm? {
        return realm?.object(ofType: CartRealm.self, forPrimaryKey: Constants.Realm.primaryKey)
    }

    func getProducts() -> [ProductRealm] {
        let result = realm?.objects(ProductRealm.self)
        return result?.compactMap { $0 } ?? []
    }
}
