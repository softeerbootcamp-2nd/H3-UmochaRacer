//
//  TwoOptionCarMakingCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/08.
//

import Foundation
import UIKit
class CarMakingCollectionViewCell: UICollectionViewCell {

    // 이미지 + 라벨 + 옵션버튼리스트뷰
    let optionImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let optionButtonListView: TwoOptionCardButtonView = {
        let twoButtonView = TwoOptionCardButtonView(type: .selfMode)
        return twoButtonView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        addSubview(optionImageView)
        addSubview(descriptionLabel)
        addSubview(optionButtonListView)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(optionImageView)
        addSubview(descriptionLabel)
        addSubview(optionButtonListView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

    }

}
