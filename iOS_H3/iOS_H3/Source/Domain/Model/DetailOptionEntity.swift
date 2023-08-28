//
//  DetailInfoEntity.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Foundation
import Combine


enum DetailOptionToEntityError: LocalizedError {
    case missingTitle
    case missingDescription

    var errorDescription: String? {
        switch self {
        case .missingTitle:
            return "제목 값이 없습니다."
        case .missingDescription:
            return "설명 값이 없습니다."
        }
    }
}

struct DetailOptionData: Decodable {
    let title: String?
    let description: String?
    let info: String?
    let imageSrc: String?
}

extension DetailOptionData {
    func toDomain() throws -> DetailOptionEntity {

        guard let title = self.title else {
            throw DetailOptionToEntityError.missingTitle
        }

        guard let description = self.description else {
            throw DetailOptionToEntityError.missingDescription
        }

        return DetailOptionEntity(
            title: title,
            description: description,
            info: self.info,
            imageSrc: self.imageSrc
        )
    }
}

struct DetailOptionEntity {
    let title: String
    let description: String
    let info: String?
    let imageSrc: String?
}

extension DetailOptionEntity {
    func toPresentation() -> DetailOptionInfo {

        let titleUR = title.toURString()
        let descriptionUR = description.toURString()
        let infoUR = self.extractDetails(from: info ?? "")
        return DetailOptionInfo(
            title: titleUR,
            description: descriptionUR,
            info: infoUR,
            imageSrc: self.imageSrc
        )
    }

    func extractDetails(from input: String) -> [[String: String]] {
        let regexPattern = "\\[?\\{\"title\": \"(.*?)\", \"description\": \"(.*?)\"\\}\\]?"

        guard let regex = try? NSRegularExpression(pattern: regexPattern) else { return [] }

        let nsInput = input as NSString
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSRange(location: 0, length: nsInput.length))

        var result = [[String: String]]()

        for match in matches {
            let titleRange = match.range(at: 1)
            let descriptionRange = match.range(at: 2)
            let titleString = nsInput.substring(with: titleRange)
                .replacingOccurrences(of: "<(?!(/)?cardb>)[^>]+>",
                                      with: "",
                                      options: .regularExpression,
                                      range: nil)
            let descriptionString = nsInput.substring(with: descriptionRange)
                .replacingOccurrences(of: "<(?!(/)?cardb>)[^>]+>",
                                      with: "",
                                      options: .regularExpression,
                                      range: nil)
            result.append(["title": titleString,
                           "description": descriptionString])
        }
        return result
    }
}

class MockDetailRepository: MockDetailRepositoryProtocol {

    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchPowertrainDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> {
        return fetchDetailInfo(endpoint: .powertrain(id: id))
    }

    func fetchDrivingSystemDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> {
        return fetchDetailInfo(endpoint: .drivingSystem(id: id))
    }

    func fetchBodyTypeDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> {
        return fetchDetailInfo(endpoint: .bodyType(id: id))
    }

    func fetchWheelDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> {
        return fetchDetailInfo(endpoint: .wheel(id: id))
    }

    func fetchAdditionalOptionDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], MockDetailRepositoryError> {
        return networkService.request(MockDetailEndPoint.additionalOption(id: id))
            .flatMap { (result: Result<APIResponse<[DetailOptionData]>, Error>)
                -> AnyPublisher<[DetailOptionEntity], MockDetailRepositoryError> in

                switch result {
                case .success(let data):
                    do {
                        let detailOptionEntities = try data.data.map { try $0.toDomain() }
                        return Just(detailOptionEntities)
                            .setFailureType(to: MockDetailRepositoryError.self)
                            .eraseToAnyPublisher()
                    } catch let error as DetailOptionToEntityError {
                        return Fail(outputType: [DetailOptionEntity].self,
                                    failure: MockDetailRepositoryError.conversionError(error))
                        .eraseToAnyPublisher()
                    } catch {
                        return Fail(outputType: [DetailOptionEntity].self,
                                    failure: MockDetailRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                    }
                case .failure(let error):

                    return Fail(outputType: [DetailOptionEntity].self,
                                failure: MockDetailRepositoryError.networkError(error))
                    .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    private func fetchDetailInfo(endpoint: MockDetailEndPoint)
    -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> {
        networkService.request(endpoint)
            .flatMap { (result: Result<APIResponse<DetailOptionData>, Error>)
                -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError> in
                switch result {
                case .success(let data):
                    do {
                        let detailOptionEntities = try data.data.toDomain()// { try  }

                        return Just(detailOptionEntities)
                            .setFailureType(to: MockDetailRepositoryError.self)
                            .eraseToAnyPublisher()
                    } catch let error as DetailOptionToEntityError {
                        return Fail(outputType: DetailOptionEntity.self,
                                    failure: MockDetailRepositoryError.conversionError(error))
                        .eraseToAnyPublisher()
                    } catch {
                        return Fail(outputType: DetailOptionEntity.self,
                                    failure: MockDetailRepositoryError.networkError(error))
                        .eraseToAnyPublisher()
                    }
                case .failure(let error):
                    return Fail(outputType: DetailOptionEntity.self,
                                failure: MockDetailRepositoryError.networkError(error))
                    .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

enum MockDetailRepositoryError: LocalizedError {
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

protocol MockDetailRepositoryProtocol {
    func fetchPowertrainDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError>

    func fetchDrivingSystemDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError>

    func fetchBodyTypeDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError>

    func fetchWheelDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, MockDetailRepositoryError>

    func fetchAdditionalOptionDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], MockDetailRepositoryError>
}
enum MockDetailEndPoint: Endpoint {
    case powertrain(id: Int)
    case drivingSystem(id: Int)
    case bodyType(id: Int)
    case wheel(id: Int)
    case additionalOption(id: Int)

    var baseURL: String { ConstantKey.baseURL }
    var httpMethod: HTTPMethod { .GET }
    var headers: [String: String] { [:] }

    var path: String {
        switch self {
        case .powertrain(let id):
            return "detail/powertrain/\(id)"
        case .drivingSystem(let id):
            return "detail/driving-system/\(id)"
        case .bodyType(let id):
            return "detail/bodytype/\(id)"
        case .wheel(let id):
            return "detail/wheel/\(id)"
        case .additionalOption(let id):
            return "detail/additional-option/\(id)"
        }
    }

    var parameters: HTTPParameter? {
       return nil
    }
}
