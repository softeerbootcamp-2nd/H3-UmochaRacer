//
//  CarMakingCollectionViewCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/08.
//

import UIKit
import Combine

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

    // MARK: - Properites

    private var optionCardInfoArray: [OptionCardInfo] = []

    var optionDidSelected = PassthroughSubject<Int, Never>()

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
        buttonListViewable.delegate = self
        setupViews()
    }

    override func prepareForReuse() {
        optionImageView.image = nil
        optionDidSelected = PassthroughSubject<Int, Never>()
    }

    // MARK: - Helpers
    func configure(carMakingStepInfo: CarMakingStepInfo) {
        configure(carMakingStepTitle: carMakingStepInfo.step.title)
        configure(optionInfoArray: carMakingStepInfo.optionCardInfoArray)

        if !carMakingStepInfo.optionCardInfoArray.isEmpty {
            let optionIndexToShowBanner = carMakingStepInfo.optionCardInfoArray.firstIndex { $0.isSelected } ?? 0
            configure(bannerImageURL: carMakingStepInfo.optionCardInfoArray[optionIndexToShowBanner].bannerImageURL)
        }
    }

    func configure(carMakingStepTitle: String) {
        self.descriptionLabel.text = carMakingStepTitle + Constants.descriptionSuffix
        self.descriptionLabel.applyBoldToString(targetString: carMakingStepTitle,
                                                font: Fonts.mediumTitle3 ?? .systemFont(ofSize: 10.0))
    }

    func configure(bannerImageURL: URL?) {
        optionImageView.loadCachedImage(of: bannerImageURL)
    }

    func configure(optionInfoArray: [OptionCardInfo]) {
        self.optionCardInfoArray = optionInfoArray
        guard let optionButtonListView = optionButtonListView as? OptionCardButtonListViewable else {
            return
        }
        optionButtonListView.updateAllViews(with: optionInfoArray)
    }

    func update(optionInfoArray: [OptionCardInfo]) {
        guard let optionButtonListView = optionButtonListView as? OptionCardButtonListViewable else {
            return
        }
//        optionButtonListView.updateAllViews(with: optionInfoArray)
        optionButtonListView.reloadViews(with: optionInfoArray)
    }
}

// MARK: - OptionCardButtonListView Delegate

extension CarMakingCollectionViewCell: OptionCardButtonListViewDelegate {

    func optionCardButtonListViewDidSelectOption(_ optionCardButtonListView: OptionCardButtonListViewable, index: Int) {
        optionDidSelected.send(index)
        if optionCardButtonListView is TwoOptionCardButtonView {
            configure(bannerImageURL: optionCardInfoArray[index].bannerImageURL)
        }
    }

    func optionCardButtonListViewDidShowOption(_ optionCardButtonListView: OptionCardButtonListViewable, index: Int) {
        if optionCardButtonListView is MultiOptionCardButtonView {
            configure(bannerImageURL: optionCardInfoArray[index].bannerImageURL)
        }
    }
}

// MARK: - Setup

extension CarMakingCollectionViewCell {
    private func setupViews() {
        addSubViews()
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
