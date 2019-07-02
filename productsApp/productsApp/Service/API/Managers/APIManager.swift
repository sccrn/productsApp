//
//  APIManager.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import Alamofire

enum APIManager: URLRequestConvertible {
    case products
    
    private var method: HTTPMethod {
        switch self {
        case .products: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .products: return Constants.Service.productsPath
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.Service.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.Service.json, forHTTPHeaderField: Constants.Service.acceptType)
        urlRequest.setValue(Constants.Service.json, forHTTPHeaderField: Constants.Service.contentType)
        
        return urlRequest
    }
}
