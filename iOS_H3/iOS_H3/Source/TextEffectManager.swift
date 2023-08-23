//
//  TextEffectManager.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit
import Combine

class TextEffectManager {
    var selectedLabel: URLabel?

    func observeLabel(_ label: URLabel) {
        label.delegate = self
    }

    func applyEffect(_ isOn: Bool, on view: UIView) {
        for subview in view.subviews {
            if let label = subview as? URLabel, let dictionaryStr = label.urString {
                observeLabel(label)
                label.setURString(dictionaryStr, isOn: isOn)
            } else {
                applyEffect(isOn, on: subview)
            }
        }
    }

    func setHighlight(on label: URLabel, range: NSRange) {
        selectedLabel?.selectedRange = nil

        selectedLabel = label
        selectedLabel?.selectedRange = range
    }
    func clearHighlight() {
        selectedLabel?.selectedRange = nil
        selectedLabel = nil
    }
}

extension TextEffectManager: URLabelDelegate {
    func label(_ label: URLabel, didSelectRange range: NSRange?) {
        if let currentSelectedLabel = selectedLabel, currentSelectedLabel != label {
            currentSelectedLabel.selectedRange = nil
        }

        if let range = range {
            setHighlight(on: label, range: range)
        } else {
            clearHighlight()
        }
    }
}
