//
//  OptionCardCell.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit
import Combine

final class OptionCardCell: UICollectionViewCell {

    static let identifier = "OptionCardCell"

    // MARK: - UI properties

    private let optionCardButton: OptionCardButton

    // MARK: - Properties

    var buttonTapSubject = PassthroughSubject<Void, Never>()

    // MARK: - Lifecycles

    init(frame: CGRect = .zero, type: OptionCardButton.OptionCardType) {
        optionCardButton = OptionCardButton(type: type)
        super.init(frame: frame)

        setupViews()
        setupButtonTapSubject()
    }
    
    init?(coder: NSCoder, type: OptionCardButton.OptionCardType) {
        optionCardButton = OptionCardButton(type: type)
        super.init(coder: coder)

        setupViews()
        setupButtonTapSubject()
    }

    override init(frame: CGRect) {
        optionCardButton = OptionCardButton(type: .selfMode)
        super.init(frame: frame)

        setupViews()
        setupButtonTapSubject()
    }

    required init?(coder: NSCoder) {
        optionCardButton = OptionCardButton(type: .selfMode)
        super.init(coder: coder)

        setupViews()
        setupButtonTapSubject()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        optionCardButton.isSelected = false
        buttonTapSubject = PassthroughSubject<Void, Never>()
    }

    // MARK: - Helpers

    func configure(cardType: OptionCardButton.OptionCardType, info: OptionCardInfo) {
        optionCardButton.update(type: cardType, cardInfo: info)
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
    
    private func setupButtonTapSubject() {
        optionCardButton.addTarget(self, action: #selector(optionButtonDidTapped), for: .touchUpInside)
    }
    
    @objc
    private func optionButtonDidTapped() {
        buttonTapSubject.send(())
    }
}
