//
//  CarMakingViewModel.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import Foundation
import Combine

final class CarMakingViewModel {

    // MARK: - Input

    struct Input {
        var viewDidLoad: PassthroughSubject<Void, Never>
        var carMakingStepDidChanged: CurrentValueSubject<CarMakingStep, Never>
        var optionDidSelected: PassthroughSubject<(step: CarMakingStep, optionIndex: Int), Never>
        var optionCategoryDidChanged: CurrentValueSubject<OptionCategoryType, Never>
    }

    // MARK: - Output

    struct Output {
        var estimateSummary = PassthroughSubject<EstimateSummary, Never>()
        var currentStepInfo = CurrentValueSubject<CarMakingStepInfo, Never>(CarMakingStepInfo(step: .powertrain))
        var optionInfoDidUpdated = PassthroughSubject<[OptionCardInfo], Never>()
        var optionInfoForCategory = PassthroughSubject<[OptionCardInfo], Never>()
        var numberOfSelectedAdditionalOption = PassthroughSubject<Int, Never>()
        var showIndicator = PassthroughSubject<Bool, Never>()
    }

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    private let selfModeUsecase: SelfModeUsecaseProtocol

    var feedbackTitle: String = ""
    var feedbackDescription: String = ""

    // MARK: - Lifecycles

    init(selfModeUsecase: SelfModeUsecaseProtocol) {
        self.selfModeUsecase = selfModeUsecase
    }

    // MARK: - Helpers

    func transform(_ input: Input) -> Output {
        let output = Output()

        input.viewDidLoad
            .flatMap { [weak self] _ -> AnyPublisher<EstimateSummary, Never> in
                guard let self = self else {
                    return Just(EstimateSummary(elements: []))
                        .eraseToAnyPublisher()
                }
                return requestEstimateSummary()
            }
            .sink(receiveValue: { summary in
                output.estimateSummary.send(summary)
            })
            .store(in: &cancellables)

        input.carMakingStepDidChanged
            .flatMap { [weak self] step -> AnyPublisher<CarMakingStepInfo, Never> in
                guard let self = self else {
                    return Just(CarMakingStepInfo(step: step))
                        .eraseToAnyPublisher()
                }
                if step == .optionSelection {
                    let currentCategory = input.optionCategoryDidChanged.value
                    return fetchAdditionalOptionInfo(category: currentCategory)
                }
                return requestCurrentStepInfo(step)
            }
            .sink(receiveValue: { carMakingStepInfo in
                output.currentStepInfo.send(carMakingStepInfo)
            })
            .store(in: &cancellables)

        input.optionDidSelected
            .sink { [weak self] (step, optionIndex) in
                guard let self else { return }

                if step == .optionSelection {
                    let currentCategory = input.optionCategoryDidChanged.value
                    let (optionInfo, numberOfSelectedOption) = selfModeUsecase.selectAdditionalOption(of: optionIndex, in: currentCategory)
                    output.optionInfoDidUpdated.send(optionInfo)
                    output.numberOfSelectedAdditionalOption.send(numberOfSelectedOption)
                } else {
                    let changedOptionInfo = selfModeUsecase.selectOption(of: optionIndex, in: step)
                    output.optionInfoDidUpdated.send(changedOptionInfo)
                }
            }
            .store(in: &cancellables)

        input.optionCategoryDidChanged
            .flatMap { [weak self] newCategory -> AnyPublisher<CarMakingStepInfo, Never> in
                guard let self = self else {
                    return Just(CarMakingStepInfo(step: .optionSelection)).eraseToAnyPublisher()
                }
                return fetchAdditionalOptionInfo(category: newCategory)
            }
            .sink { additionalOptionStepInfo in
                output.optionInfoForCategory.send(additionalOptionStepInfo.optionCardInfoArray)
            }
            .store(in: &cancellables)

        return output
    }

    private func requestEstimateSummary() -> AnyPublisher<EstimateSummary, Never> {
        return selfModeUsecase.fetchInitialEstimate()
            .catch { _ in Just(EstimateSummary(elements: [])) }
            .eraseToAnyPublisher()
    }

    private func updateEstimateSummary(step: CarMakingStep,
                                       selectedOption: OptionCardInfo) -> AnyPublisher<EstimateSummary, Never> {
        return selfModeUsecase.updateEstimateSummary(step: step, selectedOption: selectedOption)
            .eraseToAnyPublisher()
    }

    private func requestCurrentStepInfo(_ step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, Never> {
        return selfModeUsecase.fetchOptionInfo(step: step)
            .catch { error -> AnyPublisher<CarMakingStepInfo, Never> in
                return Just(CarMakingStepInfo(step: step))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func fetchAdditionalOptionInfo(category: OptionCategoryType) -> AnyPublisher<CarMakingStepInfo, Never> {
        selfModeUsecase.fetchAdditionalOptionInfo(category: category)
            .catch { error -> AnyPublisher<CarMakingStepInfo, Never> in
                // error handling : output.error.send(error)
                return Just(CarMakingStepInfo(step: .optionSelection)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
