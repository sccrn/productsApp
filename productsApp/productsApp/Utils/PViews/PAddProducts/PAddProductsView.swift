//
//  PAddProductsView.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol PAddProductsDelegate: class {
    func didChangeQuantity(for product: ProductRealm, isAddProduct: Bool)
}

class PAddProductsView: UIView, NibLoadable {
    weak var delegate: PAddProductsDelegate?
    @IBOutlet weak var productsQuantity: UILabel!
    private var product: ProductRealm?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }
    
    func configure(product: ProductRealm) {
        self.product = product
        productsQuantity.text = "\(product.quantity)"
    }
    
    
    @IBAction func actionPlusButton(_ sender: Any) {
        guard let model = product else { return }
        delegate?.didChangeQuantity(for: model, isAddProduct: true)
    }
    
    @IBAction func actionMinusButton(_ sender: Any) {
        guard let model = product else { return }
        delegate?.didChangeQuantity(for: model, isAddProduct: false)
    }
}
