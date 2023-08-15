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

    func fetchPowertrain(model: String, type: String) -> AnyPublisher<Result<PowertrainResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.powertrain(model: model, type: type))
    }
}
