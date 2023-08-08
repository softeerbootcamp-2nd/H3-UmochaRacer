//
//  TwoMoreInfoOptionCardButtonView.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/08.
//

import UIKit

final class TwoMoreInfoOptionCardButtonView: TwoOptionCardButtonView {

    convenience init(type: OptionCardButton.OptionCardType) {
        let buttons = (0..<2).map { _ in MoreInfoOptionButton(type: type) }
        self.init(button1: buttons[0], button2: buttons[1])
        setupMoreInfoOptionButtonDelegate()
    }

    private func setupMoreInfoOptionButtonDelegate() {
        optionCardButtons.forEach { button in
            guard let moreInfoButton = button as? MoreInfoOptionButton else {
                return
            }
            moreInfoButton.delegate = self
        }
    }
}

extension TwoMoreInfoOptionCardButtonView: MoreInfoOptionButtonDelegate {
    func moreInfoButtonDidTapped() {
        print(#function)
        // show alert
    }
}
