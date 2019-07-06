//
//  CheckoutViewModel.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-03.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum CheckoutAction {
    case checkout(cart: CartRealm)
    case dismiss
}

protocol CheckoutCoordinatorDelegate: class {
    func didEndPayment(_ controller: CheckoutController, didSelect action: CheckoutAction)
}

class CheckoutViewModel {
    weak var coordinator: CheckoutCoordinatorDelegate?
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    private let disposeBag = DisposeBag()
    private var tableViewList: [CheckoutSection] = []
    
    var discounts: [Discount] = []
    var cart: CartRealm
    var products = BehaviorRelay<[ProductRealm]>(value: [])
    var productsObservable: Observable<[ProductRealm]> {
        return products.asObservable()
    }
    
    init(cart: CartRealm) {
        self.cart = cart
    }

    func viewDidAppear() {
        var total: Double = 0.0
        cart.products.forEach { product in
            if let discount = setupDiscounts(product: product) {
                total += discount.discountPrice
                if discount.codeName != Constants.Discount.mug { discounts.append(discount) }
            }
        }
        realmManager.editCartTotalPrice(cart: cart, total: total)
        products.accept(Array(cart.products))
    }
    
    private func setupDiscounts(product: ProductRealm) -> Discount? {
        switch product.code {
        case Constants.Discount.mug: return .mug(product: product)
        case Constants.Discount.tshirt: return .tshirt(product: product, newPrice: 19.0)
        case Constants.Discount.voucher: return .voucher(product: product)
        default: return nil
        }
    }
}

extension CheckoutViewModel {
    func updateTableView(by products: [ProductRealm]) -> [CheckoutSection] {
        tableViewList.removeAll()
        
        tableViewList.append(.cartSection(content: [.details(cart: cart)]))
        if discountsSection().count > 0 {
            tableViewList.append(.discountSection(content: discountsSection()))
        }
        tableViewList.append(.productSection(content: productsSection()))
        return tableViewList
    }
    
    private func discountsSection() -> [CheckoutItem] {
        var array: [CheckoutItem] = []
        if discounts.count > 0 {
            discounts.forEach { discount in
                array.append(.discountDetails(discount: discount))
            }
        }
        return array
    }
    
    private func productsSection() -> [CheckoutItem] {
        var array: [CheckoutItem] = []
        if cart.products.count > 0 {
            for (index, product) in cart.products.enumerated() {
                array.append(.productDetails(product: product,
                                             isLastItem: index == cart.products.count - 1))
            }
        }
        return array
    }
    
    func typeOfSection(for section: Int) -> CheckoutSection {
        return tableViewList[section]
    }
}
