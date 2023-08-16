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

    private var optionCardButtons: [OptionCardButton]

    // MARK: - Properties

    private var selectedButtonIndex = 0

    // MARK: - LifeCycles

    init(frame: CGRect = .zero, carMakingMode: CarMakingMode) {
        optionCardButtons = (0..<2).map { _ in OptionCardButton(mode: carMakingMode) }
        super.init(frame: frame)

        setupOptionCardButtons()
        setupViews()
    }

    override init(frame: CGRect) {
        optionCardButtons = (0..<2).map { _ in OptionCardButton(mode: .selfMode) }
        super.init(frame: frame)

        setupOptionCardButtons()
        setupViews()
    }

    required init?(coder: NSCoder) {
        optionCardButtons = (0..<2).map { _ in OptionCardButton(mode: .selfMode) }
        super.init(coder: coder)

        setupOptionCardButtons()
        setupViews()
    }

    // MARK: - Helpers

    /// index에 해당하는 옵션 카드의 view를 업데이트
    func updateView(index: Int, with cardInfo: OptionCardInfo) {
        if !isValidateIndex(index) { return }

        optionCardButtons[index].update(cardInfo: cardInfo)
        if cardInfo.isSelected {
            selectOption(index: index)
        }
    }

    /// 카드 info에 따라 모든 옵션 카드의 view를 업데이트
    func updateAllViews(with cardInfos: [OptionCardInfo]) {
        optionCardButtons.enumerated().forEach { (index, _) in
            if cardInfos.count <= index { return }
            updateView(index: index, with: cardInfos[index])
        }
    }
}

extension TwoOptionCardButtonView: OptionCardButtonDelegate {

    func moreInfoButtonDidTapped() {
        print("[TwoOptionCardButtonView]", #function, "- show alert 구현 필요")
    }
}

extension TwoOptionCardButtonView {

    private func setupOptionCardButtons() {
        optionCardButtons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(optionCardButtonDidTapped(_:)), for: .touchUpInside)
            button.delegate = self
        }
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
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

    private func selectOption(index: Int) {
        if !isValidateIndex(index) { return }

        optionCardButtons[selectedButtonIndex].isSelected = false
        optionCardButtons[index].isSelected = true
        selectedButtonIndex = index
    }

    private func isValidateIndex(_ index: Int) -> Bool {
        0..<optionCardButtons.count ~= index
    }
}
