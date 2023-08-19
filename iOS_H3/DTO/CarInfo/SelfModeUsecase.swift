//
//  SelfModeUsecase.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/19.
//

import Combine

class SelfModeUsecase: SelfModeUsecaseProtocol {

    private let carInfoRepository: CarInfoRepositoryProtocol
    private var currentEstimateSummary: EstimateSummary = EstimateSummary(elements: [])

    init(carInfoRepository: CarInfoRepositoryProtocol) {
        self.carInfoRepository = carInfoRepository
    }

    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, Never> {
        return carInfoRepository
            .fetchEstimate()
            .handleEvents(receiveOutput: { estimate in
                self.currentEstimateSummary = estimate
            })
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

    func updateEstimateSummary(step: CarMakingStep, selectedOption: OptionCardInfo)
    -> AnyPublisher<EstimateSummary, Never> {

        var elements = currentEstimateSummary.elements
        if let index = elements.firstIndex(where: { $0.stepName == step.title }) {
            let newElement = EstimateSummaryElement(stepName: step.title,
                                                    selectedOption: selectedOption.title,
                                                    category: selectedOption.title,
                                                    price: Int(selectedOption.priceString) ?? 0)
            elements[index] = newElement
        }

        let updatedSummary = EstimateSummary(elements: elements)
        currentEstimateSummary = updatedSummary

        return Just(updatedSummary).eraseToAnyPublisher()
    }
}
