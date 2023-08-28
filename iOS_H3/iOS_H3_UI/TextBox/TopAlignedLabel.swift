//
//  TopAlignedLabel.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

class TopAlignedLabel: UIView {
    private var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor)
        ])
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }

    func setText(_ text: String) {
        label.text = text
    }

    func setTextColor(_ color: UIColor) {
        label.textColor = color
    }

    func setFont(_ font: UIFont) {
        label.font = font
    }
}
