//
//  URLabel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit
import Combine

protocol URLabelDelegate: AnyObject {
    func label(_ label: URLabel, didSelectRange range: NSRange?)
}

class URLabel: UILabel {
    var urString: URString?
    weak var delegate: URLabelDelegate?
    private var originalAttributedText: NSAttributedString?

    private var tapRecognizer: UITapGestureRecognizer?

    var selectedRange: NSRange? {
        didSet {
            if selectedRange != oldValue {
                revertHighlightForSelection(from: oldValue)
                applySelectedHighlight(for: selectedRange)
            }
        }
    }
    func removeDictionaryEffects() {
        selectedRange = nil
        self.attributedText = originalAttributedText
        removeTapRecognizer()
        originalAttributedText = nil
    }

    private func removeTapRecognizer() {
        if let tapRecognizer = tapRecognizer {
            self.removeGestureRecognizer(tapRecognizer)
            self.tapRecognizer = nil
        }
    }

    func setURString(_ newURString: URString, isOn: Bool) {
        urString = newURString
        if isOn {
            originalAttributedText = self.attributedText
            updateHighlights()
            setupTapRecognizer()
        } else {
            removeDictionaryEffects()
        }
    }

    func updateHighlights() {
        guard let urLabel = urString,
              let attributedText = originalAttributedText?.mutableCopy() as? NSMutableAttributedString else { return }

        for range in urLabel.cardbRange {
            let nsRange = NSRange(range)
            highlightForDictionaryActivation(range: nsRange, in: attributedText)
        }

        self.attributedText = attributedText
    }

    func applySelectedHighlight(for range: NSRange?) {
        guard let nsRange = range,
              let attributedText = originalAttributedText?.mutableCopy() as? NSMutableAttributedString else { return }

        highlightForDictionarySelection(range: nsRange, in: attributedText)

        self.attributedText = attributedText
    }

    func revertHighlightForSelection(from oldRange: NSRange?) {
        guard let nsRange = oldRange,
              let attributedText = originalAttributedText?.mutableCopy() as? NSMutableAttributedString else { return }

        highlightForDictionaryActivation(range: nsRange, in: attributedText)

        self.attributedText = attributedText
    }

    private func highlightForDictionarySelection(range: NSRange, in attributedText: NSMutableAttributedString) {
        applyAttributes(imageName: "dictionary_unselected_img",
                        range: range,
                        weight: .bold,
                        backgroundColor: .black, textColor: .white, in: attributedText)
    }

    private func highlightForDictionaryActivation(range: NSRange,
                                                  in attributedText: NSMutableAttributedString) {
        applyAttributes(imageName: "dictionary_selected_img",
                        range: range,
                        weight: .bold,
                        backgroundColor: Colors.iconYellow,
                        textColor: .black,
                        in: attributedText)
    }

    private func applyAttributes(imageName: String,
                                 range: NSRange,
                                 weight: UIFont.Weight,
                                 backgroundColor: UIColor,
                                 textColor: UIColor,
                                 in attributedText: NSMutableAttributedString) {

        insertImage(named: imageName, before: range, in: attributedText)
        setAttributes(on: range,
                      weight: weight,
                      backgroundColor: backgroundColor,
                      textColor: textColor,
                      in: attributedText)
    }

    private func insertImage(named imageName: String,
                             before range: NSRange,
                             in attributedText: NSMutableAttributedString) {
        guard let image = UIImage(named: imageName) else { return }
        let attachment = NSTextAttachment()
        attachment.image = image
        attributedText.insert(NSAttributedString(attachment: attachment), at: range.location)
    }

    private func setAttributes(on range: NSRange,
                               weight: UIFont.Weight,
                               backgroundColor: UIColor,
                               textColor: UIColor,
                               in attributedText: NSMutableAttributedString) {
        let font = UIFont.systemFont(ofSize: self.font.pointSize, weight: weight)
        attributedText.addAttributes([.backgroundColor: backgroundColor,
            .foregroundColor: textColor,
            .font: font], range: range)
    }

    private func setupTapRecognizer() {
        tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap(_:)))
        self.isUserInteractionEnabled = true
        if let tapRecognizer = tapRecognizer {
            self.addGestureRecognizer(tapRecognizer)
        }
    }

    @objc private func handleLabelTap(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self)
        guard let selectedIndex = textIndex(at: point) else { return }
        for range in urString?.cardbRange ?? [] {
            let nsRange = NSRange(range)
            if NSLocationInRange(selectedIndex, nsRange) {
                if selectedRange == nsRange {
                    selectedRange = nil
                } else {
                    selectedRange = nsRange
                }
                showTextBox(for: nsRange)
                delegate?.label(self, didSelectRange: selectedRange)
                break
            }
        }
    }

    private func showTextBox(for range: NSRange) {
        guard let viewController = self.findViewController() else { return }
        let selectedText = (text! as NSString).substring(with: range)

        let textBoxViewController = TextBoxViewController(viewModel: TextBoxViewModel())
        textBoxViewController.modalPresentationStyle = .overCurrentContext
        textBoxViewController.setTitle(title: selectedText)
        textBoxViewController.onDismiss = { [weak self] in
            self?.selectedRange = nil
            self?.updateHighlights()
        }
        viewController.present(textBoxViewController, animated: false)
    }

    func textIndex(at point: CGPoint) -> Int? {
        guard let attributedText = attributedText else { return nil }
        let (layoutManager, textContainer) = createTextLayoutComponents()
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        let paddingWidth = (self.bounds.size.width - layoutManager.boundingRect(
            forGlyphRange: layoutManager.glyphRange(for: textContainer),
            in: textContainer).size.width) / 2
        let newPoint = CGPoint(x: point.x - (paddingWidth > 0 ? paddingWidth : 0), y: point.y)
        return layoutManager.glyphIndex(for: newPoint, in: textContainer)
    }
}
