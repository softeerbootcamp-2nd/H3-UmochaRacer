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

    func fetchEstimate() -> AnyPublisher<EstimateSummary, Never> {
        networkService.request(IntroEndpoint.estimate)
            .map { (result: Result<APIResponse<[EstimateElementData]>, Error>) -> EstimateSummary in
                switch result {
                case .success(let data):
                    let array = data.data.map { $0.toDomain() }
                    return EstimateSummary(elements: array)
                case .failure(let error):
                    return EstimateSummary(elements: [])
                }
            }
            .eraseToAnyPublisher()
    }
}
