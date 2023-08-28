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

    init(frame: CGRect = .zero, carMakingMode: CarMakingMode) {
        optionCardButton = OptionCardButton(mode: carMakingMode)
        super.init(frame: frame)

        setupViews()
        setupButtonTapSubject()
    }

    init?(coder: NSCoder, carMakingMode: CarMakingMode) {
        optionCardButton = OptionCardButton(mode: carMakingMode)
        super.init(coder: coder)

        setupViews()
        setupButtonTapSubject()
    }

    override init(frame: CGRect) {
        optionCardButton = OptionCardButton(mode: .selfMode)
        super.init(frame: frame)

        setupViews()
        setupButtonTapSubject()
    }

    required init?(coder: NSCoder) {
        optionCardButton = OptionCardButton(mode: .selfMode)
        super.init(coder: coder)

        setupViews()
        setupButtonTapSubject()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        initOptionCardButton()
        buttonTapSubject = PassthroughSubject<Void, Never>()
    }

    // MARK: - Helpers

    func configure(carMakingMode: CarMakingMode, info: OptionCardInfo, step: CarMakingStep) {
        optionCardButton.update(carMakingMode: carMakingMode, cardInfo: info, step: step)
        TextEffectManager.shared.applyEffect(TextEffectManager.shared.isDictionaryFunctionActive, on: optionCardButton)
    }

    func playFeedbackAnimation(with feedbackComment: FeedbackComment, completion: (() -> Void)? = nil) {
        if optionCardButton.isSelected {
            optionCardButton.animateButton(with: feedbackComment, completion: completion)
        } else {
            completion?()
        }
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
        optionCardButton.delegate = self
    }

    private func setupButtonTapSubject() {
        optionCardButton.addTarget(self, action: #selector(optionButtonDidTapped), for: .touchUpInside)
    }

    @objc
    private func optionButtonDidTapped() {
        buttonTapSubject.send(())
    }

    private func initOptionCardButton() {
        optionCardButton.isSelected = false
        optionCardButton.setColor(nil)
        optionCardButton.setImage(url: nil)
        optionCardButton.showMoreInfoButton(false)
        optionCardButton.resetAnimatedView()
    }
}

extension OptionCardCell: OptionCardButtonDelegate {
    func optionCardButtonMoreInfoButtonDidTap(_ optionCardButton: OptionCardButton,
                                              option: OptionCardInfo,
                                              step: CarMakingStep) {
        let detailViewController = ImageDetailPopupViewController(viewModel: DetailPopupViewModel(),
                                                                  info: option, carMakingStep: step)
        detailViewController.modalPresentationStyle = .overFullScreen
        self.findViewController()?.present(detailViewController,
                                           animated: false)
    }
}
