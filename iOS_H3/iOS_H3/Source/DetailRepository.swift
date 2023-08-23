//
//  DetailRepository.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Foundation
import Combine

class DetailRepository: DetailRepositoryProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchPowertrainDetailInfo() -> AnyPublisher<DetailOptionEntity, DetailRepositoryError> {
        networkService.request(DetailEndPoint.powertrain(id: 1))
            .flatMap { (result: Result<APIResponse<DetailOptionData>, Error>)
                -> AnyPublisher<DetailOptionEntity, DetailRepositoryError> in
                switch result {
                case .success(let data):
                    do {
                        let detailOptionEntity = try data.data.toDomain()
                        return Just(detailOptionEntity)
                            .setFailureType(to: DetailRepositoryError.self)
                            .eraseToAnyPublisher()
                    } catch let error as DetailOptionToEntityError {
                        return Fail(outputType: DetailOptionEntity.self,
                                    failure: DetailRepositoryError.conversionError(error))
                            .eraseToAnyPublisher()
                    } catch {
                        return Fail(outputType: DetailOptionEntity.self,
                                    failure: DetailRepositoryError.networkError(error))
                            .eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(outputType: DetailOptionEntity.self,
                                failure: DetailRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
