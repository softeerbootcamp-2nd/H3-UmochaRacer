//
//  OptionCardButtonListViewable.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/08.
//

import UIKit

protocol OptionCardButtonListViewable: UIView {
    var optionCardButtons: [OptionCardButton] { get }
    var selectedButtonIndex: Int { get set }
}

extension OptionCardButtonListViewable {
    func selectOption(index: Int) {
        if !isValidateIndex(index) { return }

        optionCardButtons[selectedButtonIndex].isSelected = false
        optionCardButtons[index].isSelected = true
        selectedButtonIndex = index
    }

    /// index에 해당하는 옵션 카드의 view를 업데이트
    func updateView(index: Int, with cardInfo: OptionCardInfo) {
        if !isValidateIndex(index) { return }

        optionCardButtons[index].setOptionTitle(cardInfo.title)
        optionCardButtons[index].setOptionSubTitle(cardInfo.subTitle)
        optionCardButtons[index].setPrice(cardInfo.priceString)
    }

    /// 카드 info에 따라 모든 옵션 카드의 view를 업데이트
    func updateAllViews(with cardInfos: [OptionCardInfo]) {
        optionCardButtons.enumerated().forEach { (index, _) in
            updateView(index: index, with: cardInfos[index])
        }
    }

    private func isValidateIndex(_ index: Int) -> Bool {
        0..<optionCardButtons.count ~= index
    }
}
