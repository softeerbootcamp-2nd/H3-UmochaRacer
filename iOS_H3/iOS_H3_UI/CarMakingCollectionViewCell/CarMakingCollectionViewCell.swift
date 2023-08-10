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
        static let imageHeight = 310.0
        static let descriptionLabelLeadingMargin: CGFloat = 20.0
        static let descriptionLabelTopMargin: CGFloat = 26.0
        static let buttonListViewTopMargin: CGFloat = 20.0
        static let buttonListViewHeight: CGFloat = 200.0
        static let descriptionSuffix : String = "을 선택해주세요"
    }

    let optionImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "옵션을 골라주세요."
        // TODO: 폰트 누락 확인 필요.
        label.font = Fonts.regularTitle6
        label.setupLineHeight(FontLineHeights.regularTitle6)
        label.setupLetterSpacing(FontLetterSpacings.regularTitle6)
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
    }

    // MARK: - Helpers
    func configure(type: OptionCardButton.OptionCardType,
                   bannerImage: URL,
                   makingStepTitle: String,
                   optionInfos: [OptionCardInfo]) {

        // 라벨 업데이트
        self.descriptionLabel.text = makingStepTitle + Constants.descriptionSuffix
        self.descriptionLabel.applyBoldToString(targetString: makingStepTitle,
                                                font: Fonts.mediumTitle3 ?? .systemFont(ofSize: 10.0))
        // 버튼 업데이트
        let listView = optionButtonListView as? OptionCardButtonListViewable
        listView?.updateAllViews(with: optionInfos)
    }

}

extension CarMakingCollectionViewCell {
    func setupViews() {
        addSubViews()
        setupImageView()
        setupDescriptionLabel()
        setupButtonListView()
    }

    func addSubViews() {
        [optionImageView, descriptionLabel, optionButtonListView]
            .forEach {
                self.contentView.addSubview($0)
            }
    }

    func setupImageView() {
        optionImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        optionImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        optionImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        optionImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
    }

    func setupDescriptionLabel() {
        descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                  constant: Constants.descriptionLabelLeadingMargin).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.optionImageView.bottomAnchor,
                                              constant: Constants.descriptionLabelTopMargin).isActive = true
    }

    func setupButtonListView() {
        optionButtonListView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        optionButtonListView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        optionButtonListView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,
                                                   constant: Constants.buttonListViewTopMargin).isActive = true
        optionButtonListView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        optionButtonListView.heightAnchor.constraint(equalToConstant: Constants.buttonListViewHeight).isActive = true
    }
}
