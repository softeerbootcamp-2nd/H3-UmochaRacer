//
//  TwoOptionCardButtonView.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/07.
//

import UIKit

final class TwoOptionCardButtonView: UIView, OptionCardButtonListViewable {

    enum Constants {
        static let buttonSpacing = 12.0
    }

    // MARK: - UI Properties

    private(set) var optionCardButtons: [OptionCardButton]

    // MARK: - Properties

    var selectedButtonIndex = 0

    // MARK: - LifeCycles

    init(frame: CGRect = .zero, type: OptionCardButton.OptionCardType, hasMoreInfo: Bool = false) {
        if hasMoreInfo {
            optionCardButtons = (0..<2).map { _ in MoreInfoOptionButton(type: type) }
        } else {
            optionCardButtons = (0..<2).map { _ in OptionCardButton(type: type) }
        }
        super.init(frame: frame)

        setupOptionCardButtons()
        setupViews()
    }

    override init(frame: CGRect) {
        optionCardButtons = (0..<2).map { _ in OptionCardButton(type: .selfMode) }
        super.init(frame: frame)

        setupOptionCardButtons()
        setupViews()
    }

    required init?(coder: NSCoder) {
        optionCardButtons = (0..<2).map { _ in OptionCardButton(type: .selfMode) }
        super.init(coder: coder)

        setupOptionCardButtons()
        setupViews()
    }

    // MARK: - Helpers
}

extension TwoOptionCardButtonView: MoreInfoOptionButtonDelegate {

    func moreInfoButtonDidTapped() {
        print(#function)
        // show alert
    }
}

extension TwoOptionCardButtonView {

    private func setupOptionCardButtons() {
        optionCardButtons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(optionCardButtonDidTapped(_:)), for: .touchUpInside)
        }

        optionCardButtons.forEach { button in
            guard let moreInfoButton = button as? MoreInfoOptionButton else {
                return
            }
            moreInfoButton.delegate = self
        }
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
        selectOption(index: selectedButtonIndex)
    }

    @objc
    private func optionCardButtonDidTapped(_ sender: UIButton) {
        guard let selectedOptionIndex = optionCardButtons.firstIndex(where: { $0 == sender }) else {
            return
        }
        selectOption(index: selectedOptionIndex)
    }

    private func addSubviews() {
        optionCardButtons.forEach {
            addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            optionCardButtons[0].topAnchor.constraint(equalTo: self.topAnchor),
            optionCardButtons[0].leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionCardButtons[0].trailingAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: -(Constants.buttonSpacing / 2)
            ),
            optionCardButtons[0].bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            optionCardButtons[1].topAnchor.constraint(equalTo: optionCardButtons[0].topAnchor),
            optionCardButtons[1].leadingAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: (Constants.buttonSpacing / 2)
            ),
            optionCardButtons[1].trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionCardButtons[1].bottomAnchor.constraint(equalTo: self.optionCardButtons[0].bottomAnchor)
        ])
    }
}
