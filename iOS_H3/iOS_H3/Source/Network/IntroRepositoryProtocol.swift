//
//  IntroRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import Combine

protocol IntroRepositoryProtocol {

    typealias APIResult<T> = AnyPublisher<Result<T, Error>, Never>

    func fetchEstimate() -> AnyPublisher<EstimateSummary, Never>
}


