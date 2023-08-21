//
//  SelfModeUsecase.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/19.
//

import Combine

class SelfModeUsecase: SelfModeUsecaseProtocol {

    private let carInfoRepository: CarInfoRepositoryProtocol
    private let introRepsitory: IntroRepositoryProtocol
    private var currentEstimateSummary: EstimateSummary = EstimateSummary(elements: [])

    init(carInfoRepository: CarInfoRepositoryProtocol,
         introRepsitory: IntroRepositoryProtocol) {
        self.carInfoRepository = carInfoRepository
        self.introRepsitory = introRepsitory
    }

    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, SelfModeUsecaseError> {
        return introRepsitory
            .fetchEstimate()
            .mapError { error -> SelfModeUsecaseError in
                switch error {
                case IntroRepositoryError.conversionError:
                    return .conversionError(error: error)
                default:
                    return .networkError(error: error)
                }
            }
            .handleEvents(receiveOutput: { estimate in
                self.currentEstimateSummary = estimate
            })
            .eraseToAnyPublisher()
    }

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError> {
        guard let publisher = publisherForStep(step) else {
            return Fail(error: SelfModeUsecaseError.invalidStep).eraseToAnyPublisher()
        }

        return publisher
            .mapError { error -> SelfModeUsecaseError in
                switch error {
                case .networkError:
                    return .networkError(error: error)
                case .conversionError:
                    return .conversionError(error: error)
                }
            }
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
                                                    selectedOption: selectedOption.title.fullText,
                                                    category: selectedOption.title.fullText,
                                                    price: Int(selectedOption.priceString) ?? 0)
            elements[index] = newElement
        }

        let updatedSummary = EstimateSummary(elements: elements)
        currentEstimateSummary = updatedSummary

        return Just(updatedSummary).eraseToAnyPublisher()
    }

    private func publisherForStep(
        _ step: CarMakingStep
    ) -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError>? {
        switch step {
        case .powertrain:
            return carInfoRepository.fetchPowertrain(model: "asdf", type: "타입명")
        case .driveMethod:
            return carInfoRepository.fetchDrivingSystem()
        case .bodyType:
            return carInfoRepository.fetchBodyType()
        case .externalColor:
            return carInfoRepository.fetchExteriorColor()
        case .internalColor:
            return carInfoRepository.fetchInteriorColor()
        case .wheelSelection:
            return carInfoRepository.fetchWheel()
        case .optionSelection:
            return carInfoRepository.fetchAdditionalOption(category: "system")
        default:
            return nil
        }
    }
}
