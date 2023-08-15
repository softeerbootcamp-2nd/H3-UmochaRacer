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

    func fetchDrivingSystem() -> AnyPublisher<Result<DrivingSystemResponse, Error>, Never> {
           return networkService.request(CarInfoEndpoint.drivingSystem)
       }

    func fetchBodyType() -> AnyPublisher<Result<BodyTypeResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.bodyType)
    }

    func fetchExteriorColor() -> AnyPublisher<Result<ExteriorColorResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.exteriorColor)
    }

    func fetchInteriorColor() -> AnyPublisher<Result<InteriorColorResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.interiorColor)
    }

    func fetchWheel() -> AnyPublisher<Result<WheelResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.wheel)
    }

    func fetchAdditionalOption(category: String) -> AnyPublisher<Result<AdditionalOptionResponse, Error>, Never> {
        return networkService.request(CarInfoEndpoint.additionalOption(category: category))
    }
}
