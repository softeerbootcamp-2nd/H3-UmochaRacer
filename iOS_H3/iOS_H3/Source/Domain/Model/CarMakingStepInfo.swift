//
//  CarMakingStepInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/16.
//

import Foundation

struct CarMakingStepInfo: Hashable {
    let step: CarMakingStep
    var bannerImageURL: URL?
    var optionCardInfoArray: [OptionCardInfo]

    init(step: CarMakingStep, bannerImageURL: URL? = nil, optionCardInfoArray: [OptionCardInfo] = []) {
        self.step = step
        self.bannerImageURL = bannerImageURL
        self.optionCardInfoArray = optionCardInfoArray
    }
}
