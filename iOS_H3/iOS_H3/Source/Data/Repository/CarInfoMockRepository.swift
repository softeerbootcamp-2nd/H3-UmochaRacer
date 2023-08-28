//
//  CarInfoMockRepository.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/22.
//

import Foundation
import Combine

final class CarInfoMockRepository: CarInfoRepositoryProtocol {

    private func fetchCarMakingStepInfo(
        for endpoint: Endpoint,
        step: CarMakingStep
    ) -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        let stepIndex = step.rawValue
        let optionInfoArray = CarMakingMockRepositoryData.mockOption[stepIndex]
        let stepInfo = CarMakingStepInfoEntity(step: step, optionCardInfoArray: optionInfoArray)
        return Just(stepInfo).setFailureType(to: CarInfoRepositoryError.self).eraseToAnyPublisher()
    }

    func fetchPowertrain(model: String, type: String) -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.powertrain(model: model, type: type), step: .powertrain)
    }

    func fetchDrivingSystem() -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.drivingSystem, step: .driveMethod)
    }

    func fetchBodyType() -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.bodyType, step: .bodyType)
    }

    func fetchExteriorColor() -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.exteriorColor, step: .externalColor)
    }

    func fetchInteriorColor() -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.interiorColor, step: .internalColor)
    }

    func fetchWheel() -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.wheel, step: .wheelSelection)
    }

    func fetchAdditionalOption(
        category: OptionCategoryType
    ) -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        var stringCategory = ""
        switch category {
        case .system:
            stringCategory = "system"
        case .temperatureManagement:
            stringCategory = "temperature"
        case .externalDevice:
            stringCategory = "outer_device"
        case .internalDevice:
            stringCategory = "inner_device"
        }
        return fetchCarMakingStepInfo(
            for: CarInfoEndpoint.additionalOption(category: stringCategory),
            step: .optionSelection
        )
    }

    func fetchSingleExteriorColor(optionId: Int) -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        fetchCarMakingStepInfo(for: CarInfoEndpoint.singleExteriorColor(optionId: optionId), step: .externalColor)
    }

    func fetchFeedbackComment(step: CarMakingStep, optionID: Int) -> AnyPublisher<FeedbackCommentEntity, Error> {
        Just(
            FeedbackCommentEntity(comment: "디젤 엔진은 효율이 좋아요! 효율을 중시한다면, 탁월한 선택입니다.")
        )
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}

struct CarMakingMockRepositoryData {
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
        [OptionCardInfoEntity.init(
            id: 0,
            title: "<cardb>디젤</cardb> 2.2",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[0]),
         OptionCardInfoEntity.init(
            id: 1,
            title: "<cardb>가솔린</cardb> 3.8",
            subTitle: "구매자의 37%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[1])],
        [OptionCardInfoEntity.init(
            id: 2,
            title: "2WD",
            subTitle: "구매자의 72%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[2]),
         OptionCardInfoEntity.init(
            id: 3,
            title: "4WD",
            subTitle: "구매자의 82%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[0])],
        [OptionCardInfoEntity.init(
            id: 4,
            title: "7인승",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[1]),
         OptionCardInfoEntity.init(
            id: 5,
            title: "8인승",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[3])],
        [OptionCardInfoEntity.init(
            id: 6,
            title: "<cardb>크리미</cardb> 화이트 펄",
            subTitle: "구매자의 88%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[4],
            color: URColor(red: 0, green: 0, blue: 0)),
         OptionCardInfoEntity.init(
            id: 7,
            title: "<cardb>LK-99</cardb> 3.8",
            subTitle: "구매자의 12%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[0])],
        [OptionCardInfoEntity.init(
            id: 8,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[5],
            // swiftlint:disable:next line_length
            iconImageURL: URL(string: "https://github.com/sangyeon3/kakao_pathfinder_assignment/assets/68235938/fe0d0580-f5b2-47fe-80ff-bab37e6f4815")),
         OptionCardInfoEntity.init(
            id: 9,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[1])],
        [OptionCardInfoEntity.init(
            id: 10,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[0]),
         OptionCardInfoEntity.init(
            id: 11,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[4])],
        [OptionCardInfoEntity.init(
            id: 12,
            title: "<cardb>가솔린</cardb> 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[3]),
         OptionCardInfoEntity.init(
            id: 13,
            title: "<cardb>가솔린</cardb> 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 3,456,789원",
            bannerImageURL: mockURL[0])],
        [OptionCardInfoEntity.init(
            id: 14,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 0 원",
            bannerImageURL: mockURL[1]),
         OptionCardInfoEntity.init(
            id: 15,
            title: "가솔린 3.8",
            subTitle: "구매자의 63%가 선택한",
            priceString: "+ 0 원",
            bannerImageURL: mockURL[2])]
    ]
}
