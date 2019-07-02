//
//  CartRealm.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

///Our Realm's model for our cart's object.
class CartRealm: Object {
    @objc dynamic var products: [Product] = []
    @objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String {
        return "id"
    }
}
