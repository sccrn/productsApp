//
//  CartCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class CartCell: UITableViewCell {
    @IBOutlet weak var productsQuantity: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    func configure(cart: CartRealm) {
        productsQuantity.text = "\(Constants.Label.productsQuantity)\(cart.productsQuantity)"
        totalPrice.text = "\(Constants.Label.totalPrice)\(cart.price)\(Constants.Label.price)"
    }
}
