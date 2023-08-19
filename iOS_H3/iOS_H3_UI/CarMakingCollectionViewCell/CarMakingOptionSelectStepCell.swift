//
//  CarMakingOptionSelectStepCell.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/18.
//

import UIKit

class CarMakingOptionSelectStepCell: CarMakingCollectionViewCell {

    static let identifier = "CarMakingOptionSelectStepCell"

    enum Constants {
        static let prefixOfOptionCountLabel = "선택 옵션"
        static let selectedOptionCountLabelLeadingOffset = 12.0
        static let listModeButtonTrailingOffset = 16.0
        static let listModeWidth = 20.0
        static let listModeHeight = 20.0
    }

    // MARK: - UI properties

    private let selectedOptionCountLabel = UILabel()

    private let listModeButton = UIButton()

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame, buttonListViewable: MultiOptionCardButtonView.init())

        setupProperties()
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupProperties()
        setupViews()
    }

    // MARK: - Helpers

    override func update(optionInfoArray: [OptionCardInfo]) {
        super.update(optionInfoArray: optionInfoArray)
        updateSelectedOptionCountLabel(optionInfoArray: optionInfoArray)
    }

    private func updateSelectedOptionCountLabel(optionInfoArray: [OptionCardInfo]) {
        let selectedOptionCount = optionInfoArray.filter { $0.isSelected }.count
        selectedOptionCountLabel.text = "\(Constants.prefixOfOptionCountLabel) \(selectedOptionCount)"
    }
}

extension CarMakingOptionSelectStepCell {

    private func setupProperties() {
        setupSelectedOptionCountLabel()
        setupListModeButton()
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
    }

    private func setupSelectedOptionCountLabel() {
        selectedOptionCountLabel.text = "\(Constants.prefixOfOptionCountLabel) 0"
        selectedOptionCountLabel.font = Fonts.regularBody3
        selectedOptionCountLabel.textColor = Colors.subActiveBlue
        selectedOptionCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupListModeButton() {
        listModeButton.setImage(UIImage(named: "list_mode_button"), for: .normal)
        listModeButton.tintColor = .black
        listModeButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        [selectedOptionCountLabel, listModeButton]
            .forEach {
                contentView.addSubview($0)
            }
    }

    private func setupConstraints() {
        setupSelectedOptionCountLabelConstraints()
        setupListModeButtonConstraints()
    }

    private func setupSelectedOptionCountLabelConstraints() {
        NSLayoutConstraint.activate([
            selectedOptionCountLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            selectedOptionCountLabel.leadingAnchor.constraint(
                equalTo: descriptionLabel.trailingAnchor,
                constant: Constants.selectedOptionCountLabelLeadingOffset
            )
        ])
    }

    private func setupListModeButtonConstraints() {
        NSLayoutConstraint.activate([
            listModeButton.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            listModeButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.listModeButtonTrailingOffset
            ),
            listModeButton.widthAnchor.constraint(equalToConstant: Constants.listModeWidth),
            listModeButton.heightAnchor.constraint(equalToConstant: Constants.listModeHeight)
        ])
    }
}
