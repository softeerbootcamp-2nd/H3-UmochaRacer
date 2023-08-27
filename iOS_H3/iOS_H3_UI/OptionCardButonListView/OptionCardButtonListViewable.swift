//
//  OptionCardButtonListViewable.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/08.
//

import UIKit

protocol OptionCardButtonListViewDelegate: AnyObject {
    func optionCardButtonListView(
        _ optionCardButtonListView: OptionCardButtonListViewable,
        didSelectOptionAt index: Int
    )
    func optionCardButtonListView(
        _ optionCardButtonListView: OptionCardButtonListViewable,
        didDisplayOptionAt index: Int
    )
}

protocol OptionCardButtonListViewable: UIView {
    var delegate: OptionCardButtonListViewDelegate? { get set }

    func configure(with cardInfos: [OptionCardInfo], step: CarMakingStep)
    func reloadOptionCards(with cardInfos: [OptionCardInfo], step: CarMakingStep)
    func playFeedbackAnimation(with feedbackComment: FeedbackComment, completion: (() -> Void)?)
}
