//
//  CarMakingProgressBarButton.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import UIKit

final class CarMakingProgressBarButton: UIButton {

    // MARK: - UI Properties

    private let underlineLayer = CALayer()

    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            if isSelected {
                changeColor(to: Colors.mainHyundaiBlue)
            } else {
                changeColor(to: Colors.coolGrey2)
            }
        }
    }

    // MARK: - Lifecycles

    init(title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupUnderlineFrame()
    }

    // MARK: - Helpers

    func changeColor(to newColor: UIColor) {
        setTitleColor(newColor, for: .normal)
        underlineLayer.backgroundColor = newColor.cgColor
    }
}

extension CarMakingProgressBarButton {
    private func setupViews() {
        titleLabel?.font = Fonts.mediumTitle5
        titleLabel?.setupLineHeight(FontLineHeights.mediumTitle5)
        setTitleColor(Colors.coolGrey2, for: .normal)

        underlineLayer.backgroundColor = Colors.coolGrey2.cgColor
        layer.addSublayer(underlineLayer)
    }

    private func setupUnderlineFrame() {
        let underlineHeight = 2.0
        underlineLayer.frame = CGRect(
            x: 0,
            y: frame.height - underlineHeight,
            width: frame.width,
            height: underlineHeight
        )
    }
}
