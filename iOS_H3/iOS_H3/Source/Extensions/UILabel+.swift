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

private extension UILabel {
    func createMutableAttributedString() -> NSMutableAttributedString {
        if let currentAttributedText = attributedText {
            return NSMutableAttributedString(attributedString: currentAttributedText)
        } else if let text = text {
            return NSMutableAttributedString(string: text)
        } else {
            return NSMutableAttributedString()
        }
    }

    func createLayoutManager() -> NSLayoutManager {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        layoutManager.addTextContainer(textContainer)
        if let attributedText = attributedText {
            let textStorage = NSTextStorage(attributedString: attributedText)
            textStorage.addLayoutManager(layoutManager)
        }
        return layoutManager
    }
}

extension UILabel {
    func insertImage(named imageName: String,
                     before range: NSRange,
                     imageSize: CGSize = CGSize(width: 20, height: 20)) {
        guard let text = self.text, range.location != NSNotFound, range.location < text.count else { return }

        let attributedString = createMutableAttributedString()

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        let mid = font?.descender ?? 0 + (font?.capHeight ?? 0.0) - imageSize.height / 2
        imageAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: mid), size: imageSize)

        let attributedImage = NSAttributedString(attachment: imageAttachment)

        attributedString.insert(attributedImage, at: range.location)

        self.attributedText = attributedString
    }

    func setAttributes(on range: NSRange, weight: UIFont.Weight, backgroundColor: UIColor, textColor: UIColor) {
        guard let originalFont = font, let text = self.text else { return }

        let actualRange = NSRange(location: range.location, length: min(range.length, text.count - range.location))
        guard actualRange.location != NSNotFound,
              actualRange.location + actualRange.length <= text.count else { return }

        let mutableAttributedString = createMutableAttributedString()
        let newFont = UIFont.systemFont(ofSize: originalFont.pointSize, weight: weight)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment

        mutableAttributedString.addAttributes([
            .font: newFont,
            .backgroundColor: backgroundColor,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ], range: actualRange)

        self.attributedText = mutableAttributedString
    }

    func addLink(on range: NSRange, linkAction: @escaping () -> Void) {
            guard let text = self.text else { return }

            let mutableAttributedString = self.attributedText?
            .mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString(string: text)

            let urlKey = "CustomLinkActionKey"
            mutableAttributedString.addAttribute(NSAttributedString.Key(rawValue: urlKey),
                                                 value: linkAction,
                                                 range: range)
            self.attributedText = mutableAttributedString

            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(recognizer)
        }

        @objc private func handleLabelTap(_ sender: UITapGestureRecognizer) {
            let point = sender.location(in: self)
            guard let selectedIndex = textIndex(at: point) else { return }
            guard let attr = attributedText?.attributes(at: selectedIndex,
                                                        effectiveRange: nil),
                  let urlAction = attr[NSAttributedString
                    .Key(rawValue: "CustomLinkActionKey")] as? () -> Void else { return }

            urlAction()
        }
        private func textIndex(at point: CGPoint) -> Int? {
            guard let attributedText = attributedText else { return nil }

            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: self.bounds.size)
            let textStorage = NSTextStorage(attributedString: attributedText)

            textStorage.addLayoutManager(layoutManager)
            textContainer.lineFragmentPadding = 0.0
            layoutManager.addTextContainer(textContainer)

            let paddingWidth = (self.bounds.size.width - layoutManager.boundingRect(
                forGlyphRange: layoutManager.glyphRange(for: textContainer),
                in: textContainer).size.width) / 2
            let newPoint = CGPoint(x: point.x - (paddingWidth > 0 ? paddingWidth : 0), y: point.y)

            return layoutManager.glyphIndex(for: newPoint, in: textContainer)
        }

    func applyAttributes(imageName: String,
                         range: NSRange,
                         weight: UIFont.Weight,
                         backgroundColor: UIColor,
                         textColor: UIColor,
                         linkAction: @escaping () -> Void) {
        insertImage(named: imageName, before: range)
        setAttributes(on: range, weight: weight, backgroundColor: backgroundColor, textColor: textColor)
        addLink(on: range, linkAction: linkAction)
    }

    // 백카사전 On
    func highlightForDictionaryActivation(range: NSRange,
                                          linkAction: @escaping () -> Void) {
        applyAttributes(imageName: "dictionary_selected_img",
                        range: range,
                        weight: .bold,
                        backgroundColor: Colors.iconYellow,
                        textColor: .black,
                        linkAction: linkAction)
    }

    // 백카사전 단어 선택
    func highlightForDictionarySelection(range: NSRange,
                                         linkAction: @escaping () -> Void) {
        applyAttributes(imageName: "dictionary_unselected_img",
                        range: range,
                        weight: .bold,
                        backgroundColor: .black,
                        textColor: .white,
                        linkAction: linkAction)
    }

}
