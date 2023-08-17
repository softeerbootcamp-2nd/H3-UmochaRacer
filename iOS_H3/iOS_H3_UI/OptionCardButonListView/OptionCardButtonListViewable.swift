//
//  OptionCardButtonListViewable.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/08.
//

import UIKit

protocol OptionCardButtonListViewable: UIView {
    func configure(with cardInfos: [OptionCardInfo])
}
