//
//  URLabel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

class URLabel: UILabel {
    var discriptionLabel: DictionaryString?

    func setURString(_ urString: DictionaryString) {
        let attributedString = NSMutableAttributedString(string: urString.fullText)

        for range in urString.cardbRange {
            let nsRange = NSRange(range, in: urString.fullText)

            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: nsRange)
        }

        self.attributedText = attributedString
    }
}
