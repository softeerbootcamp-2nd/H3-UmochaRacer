//
//  CarOptionData.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/18.
//

import Foundation

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
    func toDomain() -> OptionCardInfo {
        let bannerImageURL = URL(string: self.imageSrc ?? "")!
        let iconImageURL = URL(string: self.iconSrc ?? "")
        let color = self.colorCode.flatMap { URColor(hex: $0) }

        return OptionCardInfo(
            title: self.name ?? "",
            subTitle: self.label ?? "",
            priceString: "+ \(self.price ?? 0)원",
            bannerImageURL: bannerImageURL, // 옵셔널로 처리
            iconImageURL: iconImageURL, // 옵셔널로 처리
            color: color,
            hasMoreInfo: false
        )
    }
}
