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
    private let disposeBag = DisposeBag()
    
    var products = BehaviorRelay<[Product]>(value: [])
    var productsObservable: Observable<[Product]> {
        return products.asObservable()
    }
    
    func loadProducts() {
        productsManager.fetchProducts().subscribe(onSuccess: { [weak self] (products) in
            self?.products.accept(products)
            }, onError: { error in
                print("error: ", error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
