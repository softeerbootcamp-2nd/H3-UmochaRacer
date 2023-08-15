//
//  CarInfoRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/15.
//

import Foundation
import Combine

protocol CarInfoRepositoryProtocol {
    func fetchPowertrain(model: String, type: String) -> AnyPublisher<Result<PowertrainResponse, Error>, Never>
   
}
