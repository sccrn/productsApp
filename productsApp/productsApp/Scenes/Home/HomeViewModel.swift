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

protocol HomeCoordinatorDelegate: class {
    func moveForwardFlow(_ controller: HomeController, didSelect cart: CartRealm)
}

class HomeViewModel {
    weak var coordinator: HomeCoordinatorDelegate?
    private lazy var productsManager: ProductManager = {
       let manager = ProductManager()
        return manager
    }()
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    private let disposeBag = DisposeBag()
    private let loadInProgress = BehaviorRelay(value: false)
    
    let onShowError = PublishSubject<String>()
    var cart = BehaviorRelay<CartRealm?>(value: nil)
    var products = BehaviorRelay<[ProductRealm]>(value: [])
    var productsObservable: Observable<[ProductRealm]> {
        return products.asObservable()
    }
    
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress.asObservable().distinctUntilChanged()
    }
    
    func viewDidAppear() {
        loadCart()
        loadProducts()
    }
    
    private func loadCart() {
        if let model = realmManager.getCartObject() {
            self.cart.accept(model)
        } else {
            let newCart = CartRealm()
            newCart.id = Constants.Realm.primaryKey
            realmManager.saveObject(objt: newCart)
        }
    }
    
    private func loadProducts() {
        loadInProgress.accept(true)
        productsManager.fetchProducts().subscribe(onSuccess: { [weak self] (products) in
                self?.loadInProgress.accept(false)
                self?.setupProducts(products: products)
            }, onError: { [weak self] error in
                self?.loadInProgress.accept(false)
                self?.onShowError.onNext(error.localizedDescription)
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
        var array: [ProductSection] = []
        if let cartSection = cartSection() { array.append(cartSection) }
        if let productSection = productSection(by: products) { array.append(productSection) }
        return array
    }
    
    func cartSection() -> ProductSection? {
        guard let model = cart.value else { return nil}
        return ProductSection.cartSection(content: [.cart(cart: model)])
    }
    
    func productSection(by products: [ProductRealm]) -> ProductSection? {
        guard let model = cart.value else { return nil }
        var array: [ProductItem] = []
        products.forEach { product in
            array.append(.product(products: product, cart: model))
        }
        return ProductSection.productSection(content: array)
    }
    
    func saveProduct(product: ProductRealm, isAddProduct: Bool) {
        guard let model = cart.value else { return }
        realmManager.editCart(objt: model, product: product, isAddProduct: isAddProduct)
        guard let cart = realmManager.getCartObject() else { return }
        let products = realmManager.getProducts()
        self.cart.accept(cart)
        self.products.accept(products)
    }
}
