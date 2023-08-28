//
//  TextEffectManager.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit
import Combine

class TextEffectManager {
    static let shared = TextEffectManager()
    private init() { }
    private var selectedLabel: URLabel?
    private (set) var isDictionaryFunctionActive: Bool = false

    func observeLabel(_ label: URLabel) {
        label.delegate = self
    }

    func applyEffect(_ isOn: Bool, on view: UIView) {
        isDictionaryFunctionActive = isOn

        if let label = view as? URLabel, let dictionaryStr = label.urString {
            observeLabel(label)
            label.setURString(dictionaryStr, isOn: isOn)
        }
    }

    func applyEffectSubviews(_ isOn: Bool, on view: UIView) {
        isDictionaryFunctionActive = isOn

        for subview in view.subviews {
            if let label = subview as? URLabel, let dictionaryStr = label.urString {
                observeLabel(label)
                label.setURString(dictionaryStr, isOn: isOn)
            } else {
                applyEffectSubviews(isOn, on: subview)
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
