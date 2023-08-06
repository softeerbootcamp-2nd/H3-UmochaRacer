//
//  CarMakingProgressBarSpacingView.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import UIKit

final class CarMakingProgressBarSpacingView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        setupUnderline()
    }

    private func setupUnderline() {
        let underlineLayer = CALayer()
        underlineLayer.backgroundColor = Colors.coolGrey2.cgColor

        let underlineHeight = 2.0
        underlineLayer.frame = CGRect(
            x: 0,
            y: frame.height - underlineHeight,
            width: frame.width,
            height: underlineHeight
        )

        layer.addSublayer(underlineLayer)
    }
}
