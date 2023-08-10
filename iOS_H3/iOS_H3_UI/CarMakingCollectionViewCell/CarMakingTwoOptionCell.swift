//
//  CarMakingTwoOptionCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/09.
//

import Foundation
class CarMakingTwoOptionCell: CarMakingCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame, buttonListViewable: TwoOptionCardButtonView.init())

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
