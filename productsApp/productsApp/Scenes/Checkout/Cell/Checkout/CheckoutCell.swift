//
//  CheckoutCell.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-03.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CheckoutCell: UITableViewCell {
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var payButton: UIButton!
    var disposedCell = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposedCell = DisposeBag()
    }
    
    func configure(total: Double) {
        totalPrice.text = "Total price: \(total)€"
    }
}
