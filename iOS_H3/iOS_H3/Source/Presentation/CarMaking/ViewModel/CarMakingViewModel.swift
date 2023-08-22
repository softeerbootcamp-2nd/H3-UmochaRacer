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
        var optionCategoryDidChanged: PassthroughSubject<OptionCategoryType, Never>
    }

    // MARK: - Output

    struct Output {
        var estimateSummary = PassthroughSubject<EstimateSummary, Never>()
        var currentStepInfo = CurrentValueSubject<CarMakingStepInfo, Never>(CarMakingStepInfo(step: .powertrain))
        var optionInfoDidUpdated = PassthroughSubject<[OptionCardInfo], Never>()
        var optionInfoForCategory = PassthroughSubject<[OptionCardInfo], Never>()
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
                return requestCurrentStepInfo(step)
            }
            .sink(receiveValue: { carMakingStepInfo in
                output.currentStepInfo.send(carMakingStepInfo)
            })
            .store(in: &cancellables)

        input.optionDidSelected
            .sink { [weak self] (_, optionIndex) in
                guard let self else { return }
                let changedOptionInfo = selfModeUsecase.selectOption(of: optionIndex)
                output.optionInfoDidUpdated.send(changedOptionInfo)
            }
            .store(in: &cancellables)

        input.optionCategoryDidChanged
            .flatMap { [weak self] newCategory -> AnyPublisher<CarMakingStepInfo, Never> in
                guard let self else { return Just(CarMakingStepInfo(step: .optionSelection)).eraseToAnyPublisher() }
                return selfModeUsecase.fetchAdditionalOptionInfo(category: newCategory)
                    .catch { error -> AnyPublisher<CarMakingStepInfo, Never> in
                        // error handling : output.error.send(error)
                        return Just(CarMakingStepInfo(step: .optionSelection)).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
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
            [OptionCardInfo.init(title: URString(fullText: "디젤 2.2"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0],
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 37%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1])],
            [OptionCardInfo.init(title: URString(fullText: "2WD"),
                                 subTitle: URString(fullText: "구매자의 72%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[2],
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "4WD"),
                                 subTitle: URString(fullText: "구매자의 82%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(title: URString(fullText: "7인승"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1],
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "8인승"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[3])],
            [OptionCardInfo.init(title: URString(fullText: "크리미 화이트 펄"),
                                 subTitle: URString(fullText: "구매자의 88%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[4],
                                 color: URColor(red: 0, green: 0, blue: 0),
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "LK-99 3.8"),
                                 subTitle: URString(fullText: "구매자의 12%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[5],
                                 // swiftlint:disable:next line_length
                                 iconImageURL: URL(string: "https://github.com/sangyeon3/kakao_pathfinder_assignment/assets/68235938/fe0d0580-f5b2-47fe-80ff-bab37e6f4815"),
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[1])],
            [OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0],
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[4])],
            [OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[3],
                                 isSelected: true),
             OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 3,456,789원",
                                 bannerImageURL: mockURL[0])],
            [OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 0 원",
                                 bannerImageURL: mockURL[1]),
             OptionCardInfo.init(title: URString(fullText: "가솔린 3.8"),
                                 subTitle: URString(fullText: "구매자의 63%가 선택한"),
                                 priceString: "+ 0 원",
                                 bannerImageURL: mockURL[2])]
    ]
}
