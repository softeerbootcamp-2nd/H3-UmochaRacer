//
//  CarMakingStepInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/21.
//

import Foundation

struct CarMakingStepInfo: Hashable {
    let step: CarMakingStep
    var optionCardInfoArray: [OptionCardInfo]

    init(step: CarMakingStep, optionCardInfoArray: [OptionCardInfo] = []) {
        self.step = step

        switch step {
        case .externalColor, .internalColor:
            self.optionCardInfoArray = optionCardInfoArray
        default:
            self.optionCardInfoArray = optionCardInfoArray.map { optionCard in
                OptionCardInfo(
                    id: optionCard.id,
                    title: optionCard.title,
                    subTitle: optionCard.subTitle,
                    priceString: optionCard.priceString,
                    bannerImageURL: optionCard.bannerImageURL,
                    iconImageURL: optionCard.iconImageURL,
                    color: optionCard.color,
                    hasMoreInfo: true,
                    isSelected: optionCard.isSelected
                )
            }
        }
    }
}
