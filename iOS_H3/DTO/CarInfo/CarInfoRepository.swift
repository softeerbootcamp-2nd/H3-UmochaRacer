//
//  CarInfoRepository.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
import Combine

final class CarInfoRepository: CarInfoRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    private func fetchCarMakingStepInfo(for endpoint: Endpoint,
                                        step: CarMakingStep)
    -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> {
        networkService.request(endpoint)
            .flatMap { (result: Result<APIResponse<[CarOptionData]>, Error>)
                -> AnyPublisher<CarMakingStepInfoEntity, CarInfoRepositoryError> in
                switch result {
                case .success(let data):
                    do {
                        let array = try data.data.map { try $0.toDomain() }
                        return Just(CarMakingStepInfoEntity(step: step, optionCardInfoArray: array))
                            .setFailureType(to: CarInfoRepositoryError.self)
                            .eraseToAnyPublisher()
                    } catch let error as CarOptionToEntityError {
                        return Fail(outputType: CarMakingStepInfoEntity.self,
                                    failure: CarInfoRepositoryError.conversionError(error))
                        .eraseToAnyPublisher()
                    } catch {
                        return Fail(outputType: CarMakingStepInfoEntity.self,
                                    failure: CarInfoRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(outputType: CarMakingStepInfoEntity.self,
                                failure: CarInfoRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
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
        typealias ResultType = Result<APIResponse<FeedbackCommentData>, Error>

        guard let endpoint = createCommentEndpoint(step: step, optionID: optionID) else {
            return Fail(error: CarInfoRepositoryError.notExistCommentEndpoint(step: step)).eraseToAnyPublisher()
        }
        return networkService.request(endpoint)
            .flatMap { (result: ResultType) -> AnyPublisher<FeedbackCommentEntity, Error> in
                switch result {
                case .success(let response):
                    do {
                        let commentEntity = try response.data.toDomain()
                        return Just(commentEntity).setFailureType(to: Error.self).eraseToAnyPublisher()
                    } catch {
                        return Fail(error: CarInfoRepositoryError.conversionError(error)).eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(error: CarInfoRepositoryError.networkError(error)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func createCommentEndpoint(step: CarMakingStep, optionID: Int) -> CommentEndpoint? {
        switch step {
        case .powertrain:
            return CommentEndpoint.powertrain(id: optionID)
        case .driveMethod:
            return CommentEndpoint.drivingSystem(id: optionID)
        case .bodyType:
            return CommentEndpoint.bodyType(id: optionID)
        case .externalColor:
            return CommentEndpoint.exteriorColor(id: optionID)
        case .internalColor:
            return CommentEndpoint.interiorColor(id: optionID)
        case .wheelSelection:
            return CommentEndpoint.wheel(id: optionID)
        default:
            return nil
        }
    }
}
