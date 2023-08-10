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
            .kern: letterSpacing
        ]
        let attributedString = NSAttributedString(
            string: text,
            attributes: attributes
        )

        attributedText = attributedString
    }

    func setupFontProperty(lineHeight: CGFloat, letterSpacing: CGFloat) {
        setupLineHeight(lineHeight)
        setupLetterSpacing(letterSpacing)
    }
/*
    해당 문자열 내의 특정 대상 문자열에 볼드체 또는 지정된 글꼴을 적용합니다.
        - targetString: 글꼴을 변경하려는 대상 부분 문자열입니다.
        - font: 대상 부분 문자열에 적용할 UIFont 객체입니다. 볼드체 또는 다른 특수 스타일을 적용하려면 이 매개변수를 사용합니다.
 */
    func applyBoldToString(targetString: String,
                           font: UIFont = .systemFont(ofSize: 10.0)) {
        let originText = self.text ?? ""
        let range = (originText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: originText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}
