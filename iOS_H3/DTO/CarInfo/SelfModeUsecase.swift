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
    private var carMakingTotalInfo: [CarMakingStep: CarMakingStepInfo] = [:]
    private var optionSelectionStepInfo: [OptionCategoryType: CarMakingStepInfo] = [:]

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
                print("usecase 첫 견적 : \(estimate)")
                self.currentEstimateSummary = estimate
            })
            .eraseToAnyPublisher()
    }

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError> {
        if let stepInfo = carMakingTotalInfo[step] {
            return Just(stepInfo).setFailureType(to: SelfModeUsecaseError.self).eraseToAnyPublisher()
        }
        return fetchOptionInfoFromServer(step: step)
    }

    func fetchAdditionalOptionInfo(
        category: OptionCategoryType
    ) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError> {
        if let stepInfo = optionSelectionStepInfo[category] {
            return Just(stepInfo).setFailureType(to: SelfModeUsecaseError.self).eraseToAnyPublisher()
        }
        return fetchAdditionalOptionInfoFromServer(category: category)
    }

    func selectOption(of optionIndex: Int, in step: CarMakingStep) -> [OptionCardInfo] {
        guard let stepInfo = carMakingTotalInfo[step] else { return [] }
        var optionInfos = stepInfo.optionCardInfoArray

        switch step {
        case .optionSelection:
            optionInfos[optionIndex].isSelected.toggle()
        default:
            optionInfos.enumerated().forEach { (index, _) in
                optionInfos[index].isSelected = false
            }
            optionInfos[optionIndex].isSelected = true
        }

        carMakingTotalInfo[step] = CarMakingStepInfo(step: step, optionCardInfoArray: optionInfos)

        return optionInfos
    }

    func selectAdditionalOption(
        of optionIndex: Int,
        in category: OptionCategoryType
    ) -> (infos: [OptionCardInfo], selectedOptionCount: Int) {
        var selectedOptionCount = optionSelectionStepInfo.reduce(0) {
            $0 + $1.value.optionCardInfoArray.filter { $0.isSelected }.count
        }
        guard let categoryInfo = optionSelectionStepInfo[category] else { return ([], selectedOptionCount) }

        var categoryOptionInfos = categoryInfo.optionCardInfoArray
        categoryOptionInfos[optionIndex].isSelected.toggle()

        selectedOptionCount += categoryOptionInfos[optionIndex].isSelected ? 1 : -1

        optionSelectionStepInfo[category] = CarMakingStepInfo(
            step: .optionSelection,
            optionCardInfoArray: categoryOptionInfos
        )

        return (categoryOptionInfos, selectedOptionCount)
    }

    func updateEstimateSummary(step: CarMakingStep, selectedOption: OptionCardInfo)
    -> AnyPublisher<EstimateSummary, Never> {

        var elements = currentEstimateSummary.elements

        if step == .optionSelection {
            if !elements.contains(where: {
                $0.stepName == step.title && $0.selectedOption == selectedOption.title.fullText }) {
                let newElement = EstimateSummaryElement(
                    stepName: step.title,
                    selectedOption: selectedOption.title.fullText,
                    category: .optionInfo,
                    price: Int(selectedOption.priceString) ?? 0
                )
                elements.append(newElement)
            }
        } else {

            if let index = elements.firstIndex(where: { $0.stepName == step.title }) {
                let newElement = EstimateSummaryElement(
                    stepName: step.title,
                    selectedOption: selectedOption.title.fullText,
                    category: elements[index].category,
                    price: Int(selectedOption.priceString) ?? 0
                )
                elements[index] = newElement
            } else {
                let newElement = EstimateSummaryElement(
                    stepName: step.title,
                    selectedOption: selectedOption.title.fullText,
                    category: .optionInfo,
                    price: Int(selectedOption.priceString) ?? 0
                )
                elements.append(newElement)
            }
        }

        let updatedSummary = EstimateSummary(elements: elements)
        currentEstimateSummary = updatedSummary

        return Just(updatedSummary).eraseToAnyPublisher()
    }

    func fetchFeedbackComment(step: CarMakingStep) -> AnyPublisher<FeedbackComment, Error> {
        guard let selectedOption = carMakingTotalInfo[step]?.optionCardInfoArray.first(where: { $0.isSelected }) else {
            return Fail(error: SelfModeUsecaseError.notExistSelectedOption).eraseToAnyPublisher()
        }
        let selectedOptionID = selectedOption.id

        return carInfoRepository.fetchFeedbackComment(step: step, optionID: selectedOptionID)
            .mapError { $0 }
            .compactMap { commentEntity in
                let splittedComment = commentEntity.comment.split(separator: "!").map { String($0) }

                let title = splittedComment.count > 0 ? "\(splittedComment[0])!": ""
                var subTitle = splittedComment.count > 1 ? splittedComment[1]: ""
                if subTitle.count > 0, subTitle[subTitle.startIndex] == " " {
                    subTitle.remove(at: subTitle.startIndex)
                }

                return FeedbackComment(title: title, subTitle: subTitle)
            }
            .eraseToAnyPublisher()
    }

    private func fetchOptionInfoFromServer(
        step: CarMakingStep
    ) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError> {
        guard let publisher = publisherForStep(step) else {
            return Fail(error: SelfModeUsecaseError.invalidStep).eraseToAnyPublisher()
        }

        return publisher
            .mapError { [weak self] error in
                guard let self else { return SelfModeUsecaseError.notExistSelf }
                return convertToSelfModeUsecaseError(from: error)
            }
            .compactMap { [weak self] stepInfoEntity -> CarMakingStepInfo? in
                guard let self else { return nil }

                var stepInfoEntity = stepInfoEntity
                if stepInfoEntity.step != .optionSelection {
                    stepInfoEntity.selectFirstOption()
                }

                carMakingTotalInfo[step] = findCardbWordAndReturn(from: stepInfoEntity)

                return carMakingTotalInfo[step]
            }
            .eraseToAnyPublisher()
    }

    private func fetchAdditionalOptionInfoFromServer(
        category: OptionCategoryType
    ) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError> {
        carInfoRepository.fetchAdditionalOption(category: category)
            .mapError { [weak self] error in
                guard let self else { return SelfModeUsecaseError.notExistSelf }
                return convertToSelfModeUsecaseError(from: error)
            }
            .compactMap { [weak self] stepInfoEntity -> CarMakingStepInfo? in
                guard let self else { return nil }
                optionSelectionStepInfo[category] = findCardbWordAndReturn(from: stepInfoEntity)
                return optionSelectionStepInfo[category]
            }
            .eraseToAnyPublisher()
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
            return carInfoRepository.fetchAdditionalOption(category: OptionCategoryType.system)
        default:
            return nil
        }
    }

    private func convertToSelfModeUsecaseError(from error: CarInfoRepositoryError) -> SelfModeUsecaseError {
        switch error {
        case .networkError:
            return .networkError(error: error)
        case .conversionError:
            return .conversionError(error: error)
        default:
            return .undefinedError(error: error)
        }
    }

    private func findCardbWordAndReturn(from stepInfoEntity: CarMakingStepInfoEntity) -> CarMakingStepInfo {
        let convertedOptionInfos = stepInfoEntity.optionCardInfoEntityArray.map { info in
            info.toPresentation(
                URTitle: info.title.toURString(),
                URSubTitle: info.subTitle.toURString()
            )
        }
        return stepInfoEntity.toPresentation(optionCardInfoArray: convertedOptionInfos)
    }
}
