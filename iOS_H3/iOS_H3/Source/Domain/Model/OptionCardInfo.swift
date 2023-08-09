//
//  OptionCardInfo.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/07.
//

import Foundation

struct OptionCardInfo: Hashable {
    let title: String
    let subTitle: String
    let priceString: String     // 예시) "+ 100,000원"
    let image: URL?
    let color: URColor?
    let hasMoreInfo: Bool       // 자세히보기 여부

    init(
        title: String,
        subTitle: String,
        priceString: String,
        image: URL? = nil,
        color: URColor? = nil,
        hasMoreInfo: Bool = false
    ) {
        self.title = title
        self.subTitle = subTitle
        self.priceString = priceString
        self.image = image
        self.color = color
        self.hasMoreInfo = hasMoreInfo
    }
}
