//
//  GuideModeOptionCardCell.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit

final class GuideModeOptionCardCell: OptionCardCell {

    static let identifier = "GuideModeOptionCardCell"

    override init(frame: CGRect) {
        super.init(frame: frame, type: .guideMode)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder, type: .guideMode)
    }
}
