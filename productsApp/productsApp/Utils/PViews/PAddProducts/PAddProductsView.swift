//
//  PAddProductsView.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit

class PAddProductsView: UIView, NibLoadable {
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var productsQuantity: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    func configure(quantity: Double) {
        productsQuantity.text = "\(quantity)"
    }
}
