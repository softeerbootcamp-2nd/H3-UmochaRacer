//
//  CarMakingCollectionViewCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/08.
//

import UIKit

class CarMakingCollectionViewCell: UICollectionViewCell {

    // MARK: - UI properties
    enum Constants {
        static let descriptionLabelLeadingMargin: CGFloat = 20.0
        static let optionImageViewBottomMargin: CGFloat = 15.0
        static let descriptionLabelHeight = 20.0
        static let descriptionLabelBottomMargin: CGFloat = 15.0
        static let buttonListViewHeight: CGFloat = 150
        static let buttonListViewBottomMargin: CGFloat = 15.0
        static let descriptionSuffix: String = "을 선택해주세요"
    }

    let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "옵션을 골라주세요."
        label.font = Fonts.regularTitle3
        label.setupLineHeight(FontLineHeights.regularTitle3)
        return label
    }()

    let optionButtonListView: UIView

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        optionButtonListView = TwoOptionCardButtonView()
        super.init(frame: frame)
        setupViews()

    }

    required init?(coder: NSCoder) {
        optionButtonListView = TwoOptionCardButtonView()
        super.init(coder: coder)
        setupViews()
    }

    init(frame: CGRect = .zero, buttonListViewable: OptionCardButtonListViewable) {
        optionButtonListView = buttonListViewable
        super.init(frame: frame)
        setupViews()
    }

    override func prepareForReuse() {
        optionImageView.image = nil
    }

    // MARK: - Helpers
    func configure(carMakingStepInfo: CarMakingStepInfo) {
        configure(carMakingStepTitle: carMakingStepInfo.step.title)
        configure(optionInfoArray: carMakingStepInfo.optionCardInfoArray)
    }

    func configure(carMakingStepTitle: String) {
        self.descriptionLabel.text = carMakingStepTitle + Constants.descriptionSuffix
        self.descriptionLabel.applyBoldToString(targetString: carMakingStepTitle,
                                                font: Fonts.mediumTitle3 ?? .systemFont(ofSize: 10.0))
    }

    func configure(optionInfoArray: [OptionCardInfo]) {
        guard let optionButtonListView = optionButtonListView as? OptionCardButtonListViewable else {
            return
        }
        optionButtonListView.configure(with: optionInfoArray)
    }

}

extension CarMakingCollectionViewCell {
    private func setupViews() {
        addSubViews()
        self.backgroundView?.backgroundColor = .blue
        setupImageView()
        setupDescriptionLabel()
        setupButtonListView()
    }

    private func addSubViews() {
        [optionImageView, descriptionLabel, optionButtonListView]
            .forEach {
                self.contentView.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }

    private func setupImageView() {
        optionImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        optionImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        optionImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        optionImageView.bottomAnchor.constraint(
            equalTo: descriptionLabel.topAnchor,
            constant: -Constants.optionImageViewBottomMargin
        ).isActive = true
    }

    private func setupDescriptionLabel() {
        descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                  constant: Constants.descriptionLabelLeadingMargin).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: Constants.descriptionLabelHeight).isActive = true
        descriptionLabel.bottomAnchor.constraint(
            equalTo: optionButtonListView.topAnchor,
            constant: -Constants.descriptionLabelBottomMargin
        ).isActive = true
    }

    private func setupButtonListView() {
        optionButtonListView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        optionButtonListView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        optionButtonListView.heightAnchor.constraint(equalToConstant: Constants.buttonListViewHeight).isActive = true
        optionButtonListView.bottomAnchor.constraint(
            equalTo: bottomAnchor,
            constant: -Constants.buttonListViewBottomMargin
        ).isActive = true
    }
}
