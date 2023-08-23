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
            .sink { [weak self] _ in
                self?.fetchEstimateSummary(to: output.estimateSummary)
            }
            .store(in: &cancellables)

        input.carMakingStepDidChanged
            .sink { [weak self] newStep in
                self?.fetchCarMakingStepInfo(
                    of: newStep,
                    category: input.optionCategoryDidChanged.value,
                    output: output.currentStepInfo
                )
            }
            .store(in: &cancellables)

        input.optionDidSelected
            .sink { [weak self] (step, optionIndex) in
                guard let self else { return }
                if step == .optionSelection {
                    selectOptionSelectionStepOption(
                        of: optionIndex,
                        category: input.optionCategoryDidChanged.value,
                        updatedOptionInfoOutput: output.optionInfoDidUpdated,
                        selectedOptionCountOutput: output.numberOfSelectedAdditionalOption
                    )
                } else {
                    selectOption(of: optionIndex, in: step, updatedOptionInfoOutput: output.optionInfoDidUpdated)
                }
            }
            .store(in: &cancellables)

        input.optionCategoryDidChanged
            .sink { [weak self] newCategory in
                self?.fetchOptionSelectionStepInfo(for: newCategory, to: output.optionInfoForCategory)
            }
            .store(in: &cancellables)

        return output
    }

    private func fetchEstimateSummary(to estimateSummary: PassthroughSubject<EstimateSummary, Never>) {
        selfModeUsecase.fetchInitialEstimate()
            .catch { _ in Just(EstimateSummary(elements: [])) }
            .sink { summary in
                estimateSummary.send(summary)
            }
            .store(in: &cancellables)
    }

    private func fetchCarMakingStepInfo(
        of step: CarMakingStep,
        category: OptionCategoryType,
        output currentStepInfo: CurrentValueSubject<CarMakingStepInfo, Never>
    ) {
        if step != .optionSelection {
            fetchCarMakingStepInfo(of: step, output: currentStepInfo)
        } else {
            fetchOptionSelectionStepInfo(for: category, output: currentStepInfo)
        }
    }

    private func fetchCarMakingStepInfo(
        of step: CarMakingStep,
        output currentStepInfo: CurrentValueSubject<CarMakingStepInfo, Never>
    ) {
        selfModeUsecase.fetchOptionInfo(step: step)
            .catch { _ in  Just(CarMakingStepInfo(step: step)) }
            .sink { carMakingStepInfo in
                currentStepInfo.send(carMakingStepInfo)
            }
            .store(in: &cancellables)
    }

    private func fetchOptionSelectionStepInfo(
        for category: OptionCategoryType,
        output currentStepInfo: CurrentValueSubject<CarMakingStepInfo, Never>
    ) {
        selfModeUsecase.fetchAdditionalOptionInfo(category: category)
            .catch { _ in Just(CarMakingStepInfo(step: .optionSelection)) }
            .sink { optionSelectionStepInfo in
                currentStepInfo.send(optionSelectionStepInfo)
            }
            .store(in: &cancellables)
    }

    private func selectOption(
        of optionIndex: Int,
        in step: CarMakingStep,
        updatedOptionInfoOutput: PassthroughSubject<[OptionCardInfo], Never>
    ) {
        updatedOptionInfoOutput.send(selfModeUsecase.selectOption(of: optionIndex, in: step))
    }

    private func selectOptionSelectionStepOption(
        of optionIndex: Int,
        category: OptionCategoryType,
        updatedOptionInfoOutput: PassthroughSubject<[OptionCardInfo], Never>,
        selectedOptionCountOutput: PassthroughSubject<Int, Never>
    ) {
        let (infos, selectedOptionCount) = selfModeUsecase.selectAdditionalOption(of: optionIndex, in: category)
        updatedOptionInfoOutput.send(infos)
        selectedOptionCountOutput.send(selectedOptionCount)
    }

    private func fetchOptionSelectionStepInfo(
        for category: OptionCategoryType,
        to optionInfoForCategory: PassthroughSubject<[OptionCardInfo], Never>
    ) {
        selfModeUsecase.fetchAdditionalOptionInfo(category: category)
            .catch { _ in Just(CarMakingStepInfo(step: .optionSelection)) }
            .sink { optionSelectionStepInfo in
                optionInfoForCategory.send(optionSelectionStepInfo.optionCardInfoArray)
            }
            .store(in: &cancellables)
    }

    private func updateEstimateSummary(
        step: CarMakingStep,
        selectedOption: OptionCardInfo) -> AnyPublisher<EstimateSummary, Never> {
        return selfModeUsecase.updateEstimateSummary(step: step, selectedOption: selectedOption).eraseToAnyPublisher()
    }
}
