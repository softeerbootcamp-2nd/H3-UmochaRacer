//
//  DetailPopupUsecase.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/25.
//

import Combine

final class DetailPopupUsecase: DetailPopupUsecaseProtocol {
    private let detailRepository: MockDetailRepositoryProtocol
    private var details: MockDetailOptionEntity = MockDetailOptionEntity(title: "",
                                                                         description: "",
                                                                         info: nil,
                                                                         imageSrc: nil)
    private var cancellables = Set<AnyCancellable>()

    init(repository: MockDetailRepositoryProtocol = MockDetailRepository(networkService: NetworkService())) {
        self.detailRepository = repository
    }

    func fetchAllDetails(step: CarMakingStep, id: Int) -> AnyPublisher<DetailOptionInfo, DetailUsecaseError> {
        guard let publisher = publisherForStep(step, id: id) else {
            return Fail<DetailOptionInfo, DetailUsecaseError>(error: DetailUsecaseError.invalidStep)
                .eraseToAnyPublisher()
        }

        return publisher
            .mapError { self.convertToDetailUsecaseError(from: $0) }
            .map { $0.toPresentation() }
            .eraseToAnyPublisher()
    }

    func fetchAllAdditionalOptions(id: Int) -> AnyPublisher<[DetailOptionInfo], DetailUsecaseError> {
        detailRepository.fetchAdditionalOptionDetailInfo(id: id)
            .mapError { self.convertToDetailUsecaseError(from: $0) }
            .map { $0.map { $0.toPresentation() } }
            .eraseToAnyPublisher()
    }

    private func publisherForStep(_ step: CarMakingStep,
                                  id: Int )
    -> AnyPublisher<MockDetailOptionEntity, MockDetailRepositoryError>? {
        switch step {
        case .powertrain:
            return detailRepository.fetchPowertrainDetailInfo(id: id)
        case .driveMethod:
            return detailRepository.fetchDrivingSystemDetailInfo(id: id)
        case .bodyType:
            return detailRepository.fetchBodyTypeDetailInfo(id: id)
        case .wheelSelection:
            return detailRepository.fetchWheelDetailInfo(id: id)
        default:
            return nil
        }
    }

    private func convertToDetailUsecaseError(from error: MockDetailRepositoryError) -> DetailUsecaseError {
        switch error {
        case .networkError:
            return .networkError(error: error)
        case .conversionError:
            return .conversionError(error: error)
        }
    }

}
