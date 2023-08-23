//
//  IntroRepository.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import Combine

final class IntroRepository: IntroRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchEstimate() -> AnyPublisher<EstimateSummary, Error> {
        networkService.request(IntroEndpoint.estimate)
            .flatMap { (result: Result<APIResponse<[EstimateElementData]>,
                        Error>) -> AnyPublisher<EstimateSummary, Error> in
                switch result {
                case .success(let data):
                    do {
                        let array = try data.data.map { try $0.toDomain() }
                        return Just(EstimateSummary(elements: array))
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } catch let error as EstimateElementToEntityError {
                        return Fail(error: IntroRepositoryError.conversionError(error)).eraseToAnyPublisher()
                    } catch {
                        return Fail(error: error).eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(error: IntroRepositoryError.networkError(error)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
