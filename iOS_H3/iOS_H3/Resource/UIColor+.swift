//
//  UIColor+.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/02.
//

import Foundation
import UIKit
extension UIColor {
    convenience init?(hex: String, alpha: Double = 1) {
        var string = ""

        if hex.lowercased().hasPrefix("0x") {
            string = hex.replacingOccurrences(of: "0x", with: "")
        } else if hex.hasPrefix("#") {
            string = hex.replacingOccurrences(of: "#", with: "")
        } else {
            string = hex
        }

        if string.count == 3 {
            var str = ""
            string.forEach {
                str.append(String(repeating: String($0), count: 2))
            }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var alphaValue = alpha
        if alpha < 0 { alphaValue = 0 }
        if alpha > 1 { alphaValue = 1 }
        let red = CGFloat((hexValue >> 16) & 0xff) / 255
        let green = CGFloat((hexValue >> 8) & 0xff) / 255
        let blue = CGFloat(hexValue & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(alphaValue))
    }
}
