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
    var products = BehaviorRelay<[Product]>(value: [])
    
    var cartObservable: Observable<CartRealm?> {
        return cart.asObservable()
    }
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress.asObservable().distinctUntilChanged()
    }
    
    func viewDidAppear() {
        loadCart()
    }
    
    private func loadCart() {
        if let model = realmManager.getCartObject() {
            loadProducts(model: model)
        } else {
            let newCart = CartRealm()
            newCart.id = Constants.Realm.primaryKey
            realmManager.saveObject(objt: newCart)
            loadProducts(model: newCart)
        }
    }
    
    private func loadProducts(model: CartRealm) {
        loadInProgress.accept(true)
        productsManager.fetchProducts().subscribe(onSuccess: { [weak self] (products) in
                self?.loadInProgress.accept(false)
                self?.products.accept(products.products)
                self?.cart.accept(model)
            }, onError: { [weak self] error in
                self?.loadInProgress.accept(false)
                self?.onShowError.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}

extension HomeViewModel {
    func updateTableView() -> [ProductSection] {
        var array: [ProductSection] = []
        if let cartSection = cartSection() { array.append(cartSection) }
        if let productSection = productSection() { array.append(productSection) }
        return array
    }
    
    private func cartSection() -> ProductSection? {
        guard let model = cart.value else { return nil}
        return ProductSection.cartSection(content: [.cart(cart: model)])
    }
    
    private func productSection() -> ProductSection? {
        guard let model = cart.value else { return nil }
        var array: [ProductItem] = []
        products.value.forEach { product in
            array.append(.product(product: product, cart: model))
        }
        return ProductSection.productSection(content: array)
    }
    
    func saveProduct(product: Product, isAddProduct: Bool) {
        guard let model = cart.value else { return }
        realmManager.editCart(objt: model, product: product, isAddProduct: isAddProduct)
        guard let cart = realmManager.getCartObject() else { return }
        self.cart.accept(cart)
    }
}
