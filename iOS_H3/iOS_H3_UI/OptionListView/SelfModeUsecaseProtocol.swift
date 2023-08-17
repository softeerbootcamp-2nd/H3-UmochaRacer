//
//  SelfModeUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import Combine
import Foundation

protocol SelfModeUsecaseProtocol {
     func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, Never>

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, Never>

    // func applyOptionToEstimate(option: OptionCardInfo) -> AnyPublisher<Result<[EstimateSummary], Error>, Never>
}

class SelfModeUsecase: SelfModeUsecaseProtocol {

    let carInfoRepository: CarInfoRepositoryProtocol

    init(carInfoRepository: CarInfoRepositoryProtocol) {
        self.carInfoRepository = carInfoRepository
    }

    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, Never> {
        let publisher = carInfoRepository.fetchEstimate()
        return publisher
            .map { summary in
                var mutableSummary = summary
                return mutableSummary
            }
            .eraseToAnyPublisher()
    }

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, Never> {
        let publisher: AnyPublisher<CarMakingStepInfo, Never>

        switch step {
        case .powertrain:
            publisher = carInfoRepository.fetchPowertrain(model: "asdf", type: "타입명")
        case .driveMethod:
            publisher = carInfoRepository.fetchDrivingSystem()
        case .bodyType:
            publisher = carInfoRepository.fetchBodyType()
        case .externalColor:
            publisher = carInfoRepository.fetchExteriorColor()
        case .internalColor:
            publisher = carInfoRepository.fetchInteriorColor()
        case .wheelSelection:
            publisher = carInfoRepository.fetchWheel()
        case .optionSelection:
            publisher = carInfoRepository.fetchAdditionalOption(category: "")
        default:
            publisher = Just(CarMakingStepInfo(step: step)).eraseToAnyPublisher()
        }

        return publisher
            .map { stepInfo in
                var mutableStepInfo = stepInfo
                if !mutableStepInfo.optionCardInfoArray.isEmpty {
                    mutableStepInfo.optionCardInfoArray[0].isSelected = true
                }
                return mutableStepInfo
            }
            .eraseToAnyPublisher()
    }

}

//    func applyOptionToEstimate(option: OptionCardInfo) -> AnyPublisher<Result<[EstimateSummary], Error>, Never> {
//
//    }
