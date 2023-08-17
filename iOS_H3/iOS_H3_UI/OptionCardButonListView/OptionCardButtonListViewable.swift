//
//  OptionCardButtonListViewable.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/08.
//

import UIKit

protocol OptionCardButtonListViewDelegate: AnyObject {
    func optionCardButtonListViewDidSelectOption(_ optionCardButtonListView: OptionCardButtonListViewable, index: Int)
    func optionCardButtonListViewDidShowOption(_ optionCardButtonListView: OptionCardButtonListViewable, index: Int)
}

protocol OptionCardButtonListViewable: UIView {
    var delegate: OptionCardButtonListViewDelegate? { get set }

    func updateAllViews(with cardInfos: [OptionCardInfo])
    func reloadViews(with cardInfos: [OptionCardInfo])
}
