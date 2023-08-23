//
//  DetailRepositoryProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/23.
//

import Combine
import Foundation

enum DetailRepositoryError: LocalizedError {
    case networkError(Error)
    case conversionError(DetailOptionToEntityError)

    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "[DetailRepositoryError] 네트워크 오류: \(error.localizedDescription)"
        case .conversionError(let error):
            return "[DetailRepositoryError] 변환 오류: \(error.localizedDescription)"
        }
    }
}

protocol DetailRepositoryProtocol {
    func fetchPowertrainDetailInfo(id : Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>

    func fetchDrivingSystemDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>

    func fetchBodyTypeDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>

    func fetchWheelDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>

    func fetchAdditionalOptionDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>

}
