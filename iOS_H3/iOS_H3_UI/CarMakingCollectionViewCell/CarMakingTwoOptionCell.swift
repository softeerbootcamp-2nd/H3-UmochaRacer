//
//  CarMakingTwoOptionCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/09.
//

import Foundation
class CarMakingTwoOptionCell: CarMakingCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect = .zero, buttonListViewable: OptionCardButtonListViewable) {
        super.init(frame: frame, buttonListViewable: buttonListViewable)
    }

}
