//
//  String+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/20.
//

import Foundation

extension String {

    static func priceStringWithoutPlus(from price: Int) -> String {
        return "\(decimalStyle(from: price))원"
    }

    static func priceStringWithPlus(from price: Int) -> String {
        return "+ \(priceStringWithoutPlus(from: price))"
    }

    static func decimalStyle(from price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
