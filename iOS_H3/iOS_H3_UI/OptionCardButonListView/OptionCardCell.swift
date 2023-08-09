//
//  OptionCardCell.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit

class OptionCardCell: UICollectionViewCell {
    
    // MARK: - UI properties

    private let optionCardButton: OptionCardButton

    // MARK: - Lifecycles

    init(frame: CGRect = .zero, type: OptionCardButton.OptionCardType) {
        optionCardButton = OptionCardButton(type: type)
        super.init(frame: frame)

        setupViews()
    }
    
    init?(coder: NSCoder, type: OptionCardButton.OptionCardType) {
        optionCardButton = OptionCardButton(type: type)
        super.init(coder: coder)

        setupViews()
    }

    override init(frame: CGRect) {
        optionCardButton = OptionCardButton(type: .selfMode)
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        optionCardButton = OptionCardButton(type: .selfMode)
        super.init(coder: coder)

        setupViews()
    }

    // MARK: - Helpers

    func configure(_ info: OptionCardInfo) {
        optionCardButton.setOptionTitle(info.title)
        optionCardButton.setOptionSubTitle(info.subTitle)
        optionCardButton.setPrice(info.priceString)
    }
}

extension OptionCardCell {
    private func setupViews() {
        optionCardButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(optionCardButton)
        NSLayoutConstraint.activate([
            optionCardButton.topAnchor.constraint(equalTo: self.topAnchor),
            optionCardButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionCardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionCardButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
