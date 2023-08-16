//
//  OptionListView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/16.
//

import UIKit

final class OptionListModeView: UIView {

    enum Constants {
        static let cellHeight = 150.0
        static let optionCardCollectionViewHeight = 150.0
        static let spacing = 10.0
        static let dotIndicatorHeight = 8.0
    }

    // MARK: - UI properties

    let containerView: UIView = UIView()
    let collectionView: UICollectionView = {
        var collectionView = UICollectionView()
        return collectionView
    }()
    

    // MARK: - Properties

    // MARK: - Lifecycles

    // MARK: - Helpers
}

