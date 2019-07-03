//
//  CartCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

protocol CartCellDelegate: class {
    func didSelectCheckout(for cart: CartRealm)
}

class CartCell: UITableViewCell {
    weak var delegate: CartCellDelegate?
    @IBOutlet weak var productsQuantity: UILabel!

    private var cart: CartRealm?
    
    func configure(cart: CartRealm) {
        self.cart = cart
        productsQuantity.text = "\(Constants.Label.productsQuantity)\(cart.productsQuantity)"
    }
    
    @IBAction func actionCheckout(_ sender: Any) {
        guard let model = cart else { return }
        delegate?.didSelectCheckout(for: model)
    }
}
