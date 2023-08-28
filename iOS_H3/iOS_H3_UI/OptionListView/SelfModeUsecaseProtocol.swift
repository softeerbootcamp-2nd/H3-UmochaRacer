//
//  SelfModeUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import Foundation
import Combine

enum SelfModeUsecaseError: LocalizedError {
    case networkError(error: Error)
    case conversionError(error: Error)
    case invalidStep
    case notExistSelectedOption
    case undefinedError(error: Error)
    case notExistSelf

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[SelfModeUsecaseError] \(error.localizedDescription)"
        case .conversionError(let error):
            return "[SelfModeUsecaseError] \(error.localizedDescription)"
        case .invalidStep:
            return "[SelfModeUsecaseError] 유효하지 않은 내차만들기 단계입니다."
        case .notExistSelectedOption:
            return "[SelfModeUsecaseError] 선택된 옵션이 없습니다."
        case .undefinedError(let error):
            return "[SelfModeUsecaseError] 정의되지 않은 에러입니다. \(error)"
        case .notExistSelf:
            return "[SelfModeUsecaseError] notExistSelf Error"
        }
    }
}

protocol SelfModeUsecaseProtocol {
    func fetchInitialEstimate() -> AnyPublisher<EstimateSummary, SelfModeUsecaseError>

    func fetchOptionInfo(step: CarMakingStep) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>

    func fetchAdditionalOptionInfo(
        category: OptionCategoryType
    ) -> AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>

    func selectOption(of optionIndex: Int, in step: CarMakingStep) -> [OptionCardInfo]

    func selectAdditionalOption(
        of optionIndex: Int,
        in category: OptionCategoryType
    ) -> (infos: [OptionCardInfo], selectedOptionCount: Int)

    func updateEstimateSummary(
        step: CarMakingStep,
        selectedOption: OptionCardInfo
    ) -> AnyPublisher<EstimateSummary, Never>

	func fetchFeedbackComment(step: CarMakingStep) -> AnyPublisher<FeedbackComment?, Error>
}
