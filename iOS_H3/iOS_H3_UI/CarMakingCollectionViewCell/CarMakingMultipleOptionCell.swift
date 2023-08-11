//
//  CarMakingMultipleOptionCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/09.
//

import Foundation

class CarMakingMultipleOptionCell: CarMakingCollectionViewCell {

    static let identifier = "CarMakingMultipleOptionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame, buttonListViewable: MultiOptionCardButtonView.init())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
