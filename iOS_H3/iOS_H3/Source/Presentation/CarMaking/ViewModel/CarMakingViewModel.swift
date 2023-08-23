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
        var stepInfoPublisher: AnyPublisher<CarMakingStepInfo, SelfModeUsecaseError>
        if step != .optionSelection {
            stepInfoPublisher = selfModeUsecase.fetchOptionInfo(step: step)
        } else {
            stepInfoPublisher = selfModeUsecase.fetchAdditionalOptionInfo(category: category)
        }
        stepInfoPublisher
            .catch { _ in  Just(CarMakingStepInfo(step: step)) }
            .sink { carMakingStepInfo in
                currentStepInfo.send(carMakingStepInfo)
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

struct CarMakingMockData {
    static let mockURL = [
        "https://cdn.autotribune.co.kr/news/photo/202101/4849_30727_3533.jpg",
         // swiftlint:disable:next line_length
         "https://i.namu.wiki/i/cBMX6XiTLltPPIawbb2zfP5Oy5RW9JybY0E5ZQ62oUYdppA2t54xDjiST7xfLe_2dL4pGN9VsBVknq4H-SYA2A.webp",
         "https://cdn.epnc.co.kr/news/photo/201804/79474_70575_4841.jpg",
         "https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089982_79.jpg",
        "https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089971_11.jpg",
         "https://itimg.chosun.com/sitedata/image/202112/03/2021120301496_0.jpg"
    ].compactMap { URL(string: $0) }

    static var mockOption = [
            [OptionCardInfo.init(id: 0,
                                 title: URString(fullText: "디젤 2.2"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0],
                                 isSelected: true),
             OptionCardInfo.init(id: 1,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 37%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1])],
            [OptionCardInfo.init(id: 2,
                                 title: URString(fullText: "2WD"),
                                 subTitle: URString(fullText: "구매자의 72%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[2],
                                 isSelected: true),
             OptionCardInfo.init(id: 3,
                                 title: URString(fullText: "4WD"),
                                 subTitle: URString(fullText: "구매자의 82%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(id: 4,
                                 title: URString(fullText: "7인승"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1],
                                 isSelected: true),
             OptionCardInfo.init(id: 5,
                                 title: URString(fullText: "8인승"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[3])],
            [OptionCardInfo.init(id: 6,
                                 title: URString(fullText: "크리미 화이트 펄"),
                                 subTitle: URString(fullText: "구매자의 88%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[4],
                                 color: URColor(red: 0, green: 0, blue: 0),
                                 isSelected: true),
             OptionCardInfo.init(id: 7,
                                 title: URString(fullText: "LK-99 3.8"),
                                 subTitle: URString(fullText: "구매자의 12%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(id: 8,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[5],
                                 // swiftlint:disable:next line_length
                                 iconImageURL: URL(string: "https://github.com/sangyeon3/kakao_pathfinder_assignment/assets/68235938/fe0d0580-f5b2-47fe-80ff-bab37e6f4815"),
                                 isSelected: true),
             OptionCardInfo.init(id: 9,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1])],
            [OptionCardInfo.init(id: 10,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0],
                                 isSelected: true),
             OptionCardInfo.init(id: 11,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[4])],
            [OptionCardInfo.init(id: 12,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[3],
                                 isSelected: true),
             OptionCardInfo.init(id: 13,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(id: 14,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 0 원",
                                 bannerImageURL: mockURL[1]),
             OptionCardInfo.init(id: 15,
                                 title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 0 원",
                                 bannerImageURL: mockURL[2])]
    ]

}
