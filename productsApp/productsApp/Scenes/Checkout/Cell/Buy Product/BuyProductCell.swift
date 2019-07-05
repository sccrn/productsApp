//
//  BuyProductCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class BuyProductCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    func configure(product: ProductRealm, isLastItem: Bool) {
        productName.text = product.name
        productQuantity.text = "\(product.quantity)"
        if !isLastItem { self.addBottomBorder(margins: 30) }
    }
}
