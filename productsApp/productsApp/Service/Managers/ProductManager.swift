//
//  ProductManager.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Alamofire
import RxSwift

class ProductManager {
    
    private func createRequest<T: Codable>(route: APIManager) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(route).responseDecodable { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchProducts() -> Single<[Product]> {
        return createRequest(route: APIManager.products).asSingle()
    }
}
