//
//  HomeViewModel.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-29.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    private lazy var productsManager: ProductManager = {
       let manager = ProductManager()
        return manager
    }()
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    private let disposeBag = DisposeBag()
    
    var cart = BehaviorRelay<CartRealm>(value: CartRealm())
    var products = BehaviorRelay<[ProductRealm]>(value: [])
    var productsObservable: Observable<[ProductRealm]> {
        return products.asObservable()
    }
    
    func loadProducts() {
        productsManager.fetchProducts().subscribe(onSuccess: { [weak self] (products) in
                self?.setupProducts(products: products)
            }, onError: { error in
                print("error: ", error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    private func setupProducts(products: Products) {
        realmManager.deleteProducts()
        var array: [ProductRealm] = []
        products.products.forEach { product in
            let model = ProductRealm()
            model.code = product.code
            model.name = product.name
            model.price = product.price
            model.quantity = 0
            array.append(model)
        }
        realmManager.saveObjects(objts: array)
        self.products.accept(array)
    }
}

extension HomeViewModel {
    func updateTableView(by products: [ProductRealm]) -> [ProductSection] {
        return [cartSection(), productSection(by: products)]
    }
    
    func cartSection() -> ProductSection {
        return ProductSection.cartSection(content: [.cart(cart: self.cart.value)])
    }
    
    func productSection(by products: [ProductRealm]) -> ProductSection {
        var array: [ProductItem] = []
        products.forEach { product in
            array.append(.product(products: product))
        }
        return ProductSection.productSection(content: array)
    }
}
