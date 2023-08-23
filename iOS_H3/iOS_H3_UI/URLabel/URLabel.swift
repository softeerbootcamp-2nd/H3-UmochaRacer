//
//  URLabel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

class URLabel: UILabel {
    var discriptionLabel: DictionaryString?
    private var selectedRange: NSRange?

    func setURString(_ urString: DictionaryString) {
        let attributedString = NSMutableAttributedString(string: urString.fullText)

        for range in urString.cardbRange {
            let nsRange = NSRange(range, in: urString.fullText)
            if nsRange == selectedRange {
                highlightForDictionarySelection(range: nsRange, linkAction: {
                    self.selectedRange = nil
                    self.setURString(urString)
                })
            } else {
                highlightForDictionaryActivation(range: nsRange, linkAction: {
                    self.selectedRange = nsRange
                    self.setURString(urString)
                })
            }
        }
        self.attributedText = attributedString
    }
}
