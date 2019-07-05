//
//  PaymentViewModel.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

protocol PaymentVMCoordinatorDelegate: class {
    func moveForwardToHome(_ controller: PaymentController)
}

class PaymentViewModel {
    weak var coordinator: PaymentVMCoordinatorDelegate?
    private var cart: CartRealm
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    
    init(cart: CartRealm) {
        self.cart = cart
    }
    
    func sendOrderCart() {
        realmManager.deleteCart(by: cart)
    }
}
