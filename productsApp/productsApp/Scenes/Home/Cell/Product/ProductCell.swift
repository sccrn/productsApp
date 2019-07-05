//
//  ProductCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addProductView: PAddProductsView!
    
    func configure(product: ProductRealm, cart: CartRealm) {
        productName.text = product.name
        productPrice.text = "\(product.price)\(Constants.Label.price)"
        let quantity = checkProductInCart(cart: cart, product: product)
        addProductView.configure(product: product, quantity: quantity)
    }
    
    private func checkProductInCart(cart: CartRealm, product: ProductRealm) -> Int {
        return cart.products.filter{"\($0.name)" == product.name}.count
    }
}
