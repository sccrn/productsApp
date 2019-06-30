//
//  Constants.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

struct Constants {
    struct Service {
        static let baseURL = "https://api.myjson.com/"
        static let productsPath = "bins/4bwec"
        static let acceptType = "Accept"
        static let contentType = "Content-Type"
        static let acceptEnconding = "Accept-Enconding"
        static let json = "application/json"
    }
    
    struct Screen {
        static let home = "Products"
    }
    
    struct Label {
        static let sectionTitle = "Hello! Choose your products! :)"
    }
}
