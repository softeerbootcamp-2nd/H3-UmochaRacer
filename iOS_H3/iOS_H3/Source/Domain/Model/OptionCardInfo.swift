//
//  OptionCardInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/07.
//

import Foundation

struct OptionCardInfo: Hashable {
    private let id = UUID()
    let title: String
    let subTitle: String
    let priceString: String     // 예시) "+ 100,000원"
    let bannerImageURL: URL    // 옵션 카드 상단 큰 이미지
    let iconImageURL: URL?          // 내장 색상 옵션에만 존재하는 이미지
    let color: URColor?
    let hasMoreInfo: Bool       // 자세히보기 여부
    var isSelected: Bool

    init(
        title: String,
        subTitle: String,
        priceString: String,
        bannerImageURL: URL,
        iconImageURL: URL? = nil,
        color: URColor? = nil,
        hasMoreInfo: Bool = false,
        isSelected: Bool = false
    ) {
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
