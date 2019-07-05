//
//  CheckoutSection.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-04.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

enum CheckoutItem {
    case details(cart: CartRealm)
    case discountDetails(discount: Discount)
    case productDetails(product: ProductRealm, isLastItem: Bool)
}

enum CheckoutSection {
    case cartSection(content: [CheckoutItem])
    case discountSection(content: [CheckoutItem])
    case productSection(content: [CheckoutItem])
}

extension CheckoutSection: SectionModelType {
    typealias Item = CheckoutItem
    
    var items: [Item] {
        switch self {
        case .cartSection(let content): return content.map { $0 }
        case .discountSection(let content): return content.map { $0 }
        case .productSection(let content): return content.map { $0 }
        }
    }
    
    init(original: CheckoutSection, items: [Item]) {
        switch original {
        case .cartSection(let content): self = .cartSection(content: content)
        case .discountSection(let content): self = .discountSection(content: content)
        case .productSection(let content): self = .productSection(content: content)
        }
    }
}
