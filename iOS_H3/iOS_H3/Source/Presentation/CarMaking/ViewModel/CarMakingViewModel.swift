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
        var nextButtonDidTapped: PassthroughSubject<Void, Never>
    }

    // MARK: - Output

    struct Output {
        var estimateSummary = PassthroughSubject<EstimateSummary, Never>()
        var currentStepInfo = CurrentValueSubject<CarMakingStepInfo, Never>(CarMakingStepInfo(step: .powertrain))
        var optionInfoDidUpdated = PassthroughSubject<[OptionCardInfo], Never>()
        var optionInfoForCategory = PassthroughSubject<[OptionCardInfo], Never>()
        var numberOfSelectedAdditionalOption = PassthroughSubject<Int, Never>()
        var feedbackComment = PassthroughSubject<FeedbackComment, Never>()
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
                if newStep != .optionSelection {
                    self?.fetchCarMakingStepInfo(of: newStep, to: output.currentStepInfo)
                } else {
                    self?.fetchOptionSelectionStepInfo(
                        for: input.optionCategoryDidChanged.value,
                        to: output.currentStepInfo
                    )
                }
            }
            .store(in: &cancellables)

        input.optionDidSelected
            .sink { [weak self] (step, optionIndex) in
                guard let self else { return }

                if step == .optionSelection {
                    let (updatedOptionInfo, selectedOptionCount) = selectOptionSelectionStepOption(
                        of: optionIndex,
                        category: input.optionCategoryDidChanged.value
                    )
                    output.optionInfoDidUpdated.send(updatedOptionInfo)
                    output.numberOfSelectedAdditionalOption.send(selectedOptionCount)
                } else {
                    let updatedOptionInfo = selectOption(of: optionIndex, in: step)
                    output.optionInfoDidUpdated.send(updatedOptionInfo)
                }
            }
            .store(in: &cancellables)

        input.optionCategoryDidChanged
            .sink { [weak self] newCategory in
                self?.fetchOptionSelectionStepInfo(for: newCategory, to: output.optionInfoForCategory)
            }
            .store(in: &cancellables)

        input.nextButtonDidTapped
            .sink { [weak self] in
                guard let self else { return }
                fetchFeedbackComment(for: input.carMakingStepDidChanged.value, to: output.feedbackComment)
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
        to currentStepInfo: CurrentValueSubject<CarMakingStepInfo, Never>
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
        to currentStepInfo: CurrentValueSubject<CarMakingStepInfo, Never>
    ) {
        selfModeUsecase.fetchAdditionalOptionInfo(category: category)
            .catch { _ in Just(CarMakingStepInfo(step: .optionSelection)) }
            .sink { optionSelectionStepInfo in
                currentStepInfo.send(optionSelectionStepInfo)
            }
            .store(in: &cancellables)
    }

    private func selectOption(of optionIndex: Int, in step: CarMakingStep) -> [OptionCardInfo] {
        return selfModeUsecase.selectOption(of: optionIndex, in: step)
    }

    private func selectOptionSelectionStepOption(
        of optionIndex: Int,
        category: OptionCategoryType
    ) -> (infos: [OptionCardInfo], selectedOptionCount: Int) {
        return selfModeUsecase.selectAdditionalOption(of: optionIndex, in: category)
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

    private func fetchFeedbackComment(for step: CarMakingStep, to feedbackCommentSubject: PassthroughSubject<FeedbackComment, Never>) {
        selfModeUsecase.fetchFeedbackComment(step: step)
            .catch { _ in Just(FeedbackComment(title: "", subTitle: "")).eraseToAnyPublisher() }
            .sink { feedbackComment in
                feedbackCommentSubject.send(feedbackComment)
            }
            .store(in: &cancellables)
    }
}
