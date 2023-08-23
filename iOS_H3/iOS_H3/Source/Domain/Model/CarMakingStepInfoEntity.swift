//
//  CarMakingStepInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/16.
//

import Foundation

struct CarMakingStepInfoEntity {
    let step: CarMakingStep
    var optionCardInfoEntityArray: [OptionCardInfoEntity]

    init(step: CarMakingStep, optionCardInfoArray: [OptionCardInfoEntity] = []) {
        self.step = step
        self.optionCardInfoEntityArray = optionCardInfoArray
    }

    func toPresentation(optionCardInfoArray: [OptionCardInfo]) -> CarMakingStepInfo {
        CarMakingStepInfo(step: step, optionCardInfoArray: optionCardInfoArray)
    }

    mutating func selectFirstOption() {
        if !optionCardInfoEntityArray.isEmpty {
            optionCardInfoEntityArray[0].isSelected = true
        }
    }
}
