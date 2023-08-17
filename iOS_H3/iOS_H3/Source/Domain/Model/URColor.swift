//
//  URColor.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import Foundation

struct URColor: Hashable {
    let red: Int8
    let green: Int8
    let blue: Int8

    init(red: Int8, green: Int8, blue: Int8) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    init(hex: String) {
        let hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0

        if scanner.scanHexInt64(&rgb) {
            let red = Int8((rgb & 0xFF0000) >> 16)
            let green = Int8((rgb & 0x00FF00) >> 8)
            let blue = Int8(rgb & 0x0000FF)

            self.init(red: red, green: green, blue: blue)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}
