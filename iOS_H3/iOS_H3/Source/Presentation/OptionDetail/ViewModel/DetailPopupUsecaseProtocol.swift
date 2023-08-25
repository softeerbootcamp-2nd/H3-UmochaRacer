//
//  DetailPopupUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

protocol DetailPopupUsecaseProtocol {
    func fetchAllDetails(step: CarMakingStep, id: Int) -> AnyPublisher<DetailOptionInfo, Never>
    func fetchDetailInfo(forPage page: Int) -> AnyPublisher<DetailOptionInfo, Never>
}

final class DetailPopupUsecase: DetailPopupUsecaseProtocol {
    private let detailRepository: DetailRepositoryProtocol
    private var details: DetailOptionEntity = DetailOptionEntity(title: "", description: "", info: nil, imageSrc: nil)
    private var cancellables = Set<AnyCancellable>()

    init(repository: DetailRepositoryProtocol = DetailRepository(networkService: NetworkService())) {
        self.detailRepository = repository
    }

    func fetchAllDetails(step: CarMakingStep, id: Int) -> AnyPublisher<DetailOptionInfo, Never> {
        return detailRepository.fetchPowertrainDetailInfo(id: id)
            .catch { _ in Just(DetailOptionEntity(title: "", description: "", info: nil, imageSrc: nil)) }
            .map { originalDetail -> DetailOptionInfo in
                return originalDetail.toPresentation()
            }
            .eraseToAnyPublisher()
    }

    func fetchDetailInfo(forPage page: Int) -> AnyPublisher<DetailOptionInfo, Never> {
        guard page < 2 else {
            return Just(DetailOptionEntity(title: "", description: "", info: nil, imageSrc: nil).toPresentation())
                .eraseToAnyPublisher()
        }
        return Just(details.toPresentation()).eraseToAnyPublisher()
    }
}
