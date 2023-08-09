//
//  SelfModeOptionCardCell.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit

final class SelfModeOptionCardCell: OptionCardCell {

    static let identifier = "SelfModeOptionCardCell"

    override init(frame: CGRect) {
        super.init(frame: frame, type: .selfMode)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder, type: .selfMode)
    }
}
