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
    
    func editCart(objt: CartRealm, product: ProductRealm, isAddProduct: Bool) {
        try? realm!.write ({
            if objt.products.count > 0 {
                if let index = objt.products.index(of: product) {
                    objt.products.remove(at: index)
                }
            }
            if isAddProduct {
                product.quantity += 1
            } else if product.quantity > 0 && !isAddProduct {
                product.quantity -= 1
            }
            if product.quantity > 0 { objt.products.append(product) }
            var quantity: Int = 0
            objt.productsQuantity = 0
            objt.products.forEach { prod in
                quantity += prod.quantity
            }
            objt.productsQuantity = quantity
            realm?.add(product, update: true)
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
