//
//  ProductRealm.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

///Our Realm's model for our product's object.
class ProductRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var code: String = ""
    @objc dynamic var price: Double = 0.0
    @objc dynamic var quantity: Int = 0
    
    override static func primaryKey() -> String {
        return "name"
    }
}
