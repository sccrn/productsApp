//
//  SectionProducts.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-30.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct SectionProducts {
    var items: [Product]
    var header: String = ""
}

extension SectionProducts: SectionModelType {
    init(original: SectionProducts, items: [Product]) {
        self = original
        self.items = items
    }
}
