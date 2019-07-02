//
//  Array.swift
//  productsApp
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-07-02.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

extension Array {
    func removingDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(key(value)).inserted {
                result.append(value)
            }
        }
        return result
    }
}
