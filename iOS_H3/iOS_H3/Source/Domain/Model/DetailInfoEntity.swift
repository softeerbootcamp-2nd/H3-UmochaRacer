//
//  DetailInfoEntity.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Foundation
import Combine

// struct DetailInfoEntity {
//    let title: String
//    let subTitle: String
//    let description: String
//    let additionalInfo: String
//    let imageURL: URL?
// }

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

class DetailRepository: DetailRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchPowertrainDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, DetailRepositoryError> {
        return fetchDetailInfo(endpoint: .powertrain(id: id))
    }
    
    //    func fetchDrivingSystemDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError> {
    //        return fetchDetailInfo(endpoint: .drivingSystem(id: id))
    //    }
    //
    //    func fetchBodyTypeDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError> {
    //        return fetchDetailInfo(endpoint: .bodyType(id: id))
    //    }
    //
    //    func fetchWheelDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError> {
    //        return fetchDetailInfo(endpoint: .wheel(id: id))
    //    }
    //
    //    func fetchAdditionalOptionDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError> {
    //        return fetchDetailInfo(endpoint: .additionalOption(id: id))
    //    }
    
    private func fetchDetailInfo(endpoint: DetailEndPoint)
    -> AnyPublisher<DetailOptionEntity, DetailRepositoryError> {
        networkService.request(endpoint)
            .flatMap { (result: Result<APIResponse<DetailOptionData>, Error>)
                -> AnyPublisher<DetailOptionEntity, DetailRepositoryError> in
                switch result {
                case .success(let data):
                    do {
                        let detailOptionEntities = try data.data.toDomain()// { try  }
                        print(detailOptionEntities)
                        return Just(detailOptionEntities)
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
                    print("네트워크 에러 : ", error)
                    return Fail(outputType: DetailOptionEntity.self,
                                failure: DetailRepositoryError.networkError(error))
                    .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

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
    func fetchPowertrainDetailInfo(id: Int) -> AnyPublisher<DetailOptionEntity, DetailRepositoryError>
    //
    //    func fetchDrivingSystemDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>
    //
    //    func fetchBodyTypeDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>
    //
    //    func fetchWheelDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>
    //
    //    func fetchAdditionalOptionDetailInfo(id: Int) -> AnyPublisher<[DetailOptionEntity], DetailRepositoryError>
    
}
enum DetailEndPoint: Endpoint {
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
        case .drivingSystem:
            return "detail/driving-system"
        case .bodyType:
            return "detail/bodytype"
        case .wheel:
            return "detail/wheel"
        case .additionalOption:
            return "detail/additional-option"
        }
    }
    
    var parameters: HTTPParameter? {
        switch self {
            
        case .powertrain:
            return nil
        case .drivingSystem(let id):
            return .query(["id": "\(id)"])
        case .bodyType(let id):
            return .query(["id": "\(id)"])
        case .wheel(let id):
            return .query(["id": "\(id)"])
        case .additionalOption(let id):
            return .query(["id": "\(id)"])
        }
    }
    
}
