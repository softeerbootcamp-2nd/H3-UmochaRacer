//
//  UILabel+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/03.
//

import UIKit

extension UILabel {
    func setupLineHeight(_ lineHeight: CGFloat) {
        guard let text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight

        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .baselineOffset: (lineHeight - font.lineHeight) / 2
        ]
        let attributedString = NSAttributedString(
            string: text,
            attributes: attributes
        )

        attributedText = attributedString
    }
    
    func setupLetterSpacing(_ spacing: CGFloat) {
        guard let text else { return }
        
        let letterSpacing = font.pointSize * spacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: letterSpacing,
        ]
        let attributedString = NSAttributedString(
            string: text,
            attributes: attributes
        )

        attributedText = attributedString
    }
}
