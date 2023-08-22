//
//  TextEffectManager.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

class TextEffectManager {
    static func applyEffect(on view: UIView) {
        for subview in view.subviews {
            if let label = subview as? URLabel {
                if let dictionaryStr = label.discriptionLabel {
                    label.setURString(dictionaryStr)
                }
            } else {
                applyEffect(on: subview)
            }
        }
    }
}
