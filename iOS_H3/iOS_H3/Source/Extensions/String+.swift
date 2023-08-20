//
//  String+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/20.
//

import Foundation

extension String {
    static func priceString(from price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
