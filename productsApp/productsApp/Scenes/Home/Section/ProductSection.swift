//
//  ProductSection.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

enum ProductItem {
    case cart(cart: CartRealm)
    case product(products: ProductRealm)
}

enum ProductSection {
    case cartSection(content: [ProductItem])
    case productSection(content: [ProductItem])
}

extension ProductSection: SectionModelType {
    typealias Item = ProductItem
    
    var items: [Item] {
        switch self {
        case .cartSection(let content): return content.map { $0 }
        case .productSection(let content): return content.map { $0 }
        }
    }
    
    init(original: ProductSection, items: [Item]) {
        switch original {
        case .cartSection(let content): self = .cartSection(content: content)
        case .productSection(let content): self = .productSection(content: content)
        }
    }
}
