//
//  CartRealm.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

///Our Realm's model for our cart's object.
class CartRealm: Object {
    @objc dynamic var products = RLMArray<Object>(objectClassName: ProductRealm.className())
    @objc dynamic var productsQuantity: Int = 0
    @objc dynamic var price: Double = 0.0
    @objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String {
        return "id"
    }
}
