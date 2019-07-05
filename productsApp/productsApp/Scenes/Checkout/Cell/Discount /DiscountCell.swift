//
//  DiscountCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class DiscountCell: UITableViewCell {
    @IBOutlet weak var discountCode: UILabel!
    @IBOutlet weak var discountDescription: UILabel!
    
    func configure(discount: Discount) {
        discountCode.text = discount.codeName
        discountDescription.text = discount.description
    }
}
