//
//  CarOptionData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/18.
//

import Foundation

enum CarOptionToEntityError: LocalizedError {
    case missingID
    case missingName
    case missingTitle

    var errorDescription: String? {
        switch self {
        case .missingID:
            return "ID 값이 없습니다."
        case .missingName:
            return "이름 값이 없습니다."
        case .missingTitle:
            return "제목 값이 없습니다."

        }
    }
}

struct CarOptionData: Decodable {
    let id: Int?
    let name: String?
    let label: String?
    let price: Int?
    let imageSrc: String?
    let iconSrc: String?
    let colorCode: String?
    let parts: String?
    let partsSrc: String?
}

extension CarOptionData {
    func toDomain() throws -> OptionCardInfo {

        guard let id = self.id else {
            throw CarOptionToEntityError.missingID
        }

        guard let name = self.name else {
            throw CarOptionToEntityError.missingName
        }

        let priceString = String.priceString(from: price ?? 0)
        let bannerImageURL = URL(string: self.imageSrc ?? "")!
        let iconImageURL = URL(string: self.iconSrc ?? "")
        let color = self.colorCode.flatMap { URColor(hex: $0) }

        return OptionCardInfo(
            title: self.name ?? "",
            subTitle: self.label ?? "",
            priceString: "+ \(priceString)원",
            bannerImageURL: bannerImageURL, // 옵셔널로 처리
            iconImageURL: iconImageURL, // 옵셔널로 처리
            color: color,
            hasMoreInfo: false
        )
    }
}
