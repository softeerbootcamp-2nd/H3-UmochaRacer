//
//  Int+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/13.
//

import Foundation

extension Int {
    func toPriceString() -> String {
        var price = self
        var priceString = [String]()
        while price != 0 {
            let three = price % 1000
            price /= 1000
            priceString.append(String(three))
        }
        priceString.reverse()
        return priceString.joined(separator: ",")
    }
}
