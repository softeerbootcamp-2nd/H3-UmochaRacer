//
//  OptionCardInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/21.
//

import Foundation

struct OptionCardInfo: Hashable {
    let id: Int
    let title: URString
    let subTitle: URString
    let priceString: String     // 예시) "+ 100,000원"
    let bannerImageURL: URL?    // 옵션 카드 상단 큰 이미지
    let iconImageURL: URL?          // 내장 색상 옵션에만 존재하는 이미지
    let color: URColor?
    let hasMoreInfo: Bool       // 자세히보기 여부
    var isSelected: Bool

    init(
        id: Int,
        title: URString,
        subTitle: URString,
        priceString: String,
        bannerImageURL: URL? = nil,
        iconImageURL: URL? = nil,
        color: URColor? = nil,
        hasMoreInfo: Bool = false,
        isSelected: Bool = false
    ) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.priceString = priceString
        self.bannerImageURL = bannerImageURL
        self.iconImageURL = iconImageURL
        self.color = color
        self.hasMoreInfo = hasMoreInfo
        self.isSelected = isSelected
    }
}
