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
        static let buttonListViewHeight: CGFloat = 150
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
        // TODO: 폰트 누락 확인 필요.
        label.font = Fonts.regularTitle3
        label.setupLineHeight(FontLineHeights.regularTitle3)
        label.setupLetterSpacing(FontLetterSpacings.regularTitle3)
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
    func configure(mode: CarMakingMode,
                   bannerImage: String?,
                   makingStepTitle: String,
                   optionInfos: [OptionCardInfo]) {

        if let urlString = bannerImage {
            self.optionImageView.loadCachedImage(of: urlString)
        }

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
        optionImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight).isActive = true
    }

    private func setupDescriptionLabel() {
        descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                                  constant: Constants.descriptionLabelLeadingMargin).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: self.optionImageView.bottomAnchor,
                                              constant: Constants.descriptionLabelTopMargin).isActive = true
    }

    private func setupButtonListView() {
        optionButtonListView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        optionButtonListView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        optionButtonListView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor,
                                                   constant: Constants.buttonListViewTopMargin).isActive = true
        optionButtonListView.heightAnchor.constraint(equalToConstant: Constants.buttonListViewHeight).isActive = true
    }
}
