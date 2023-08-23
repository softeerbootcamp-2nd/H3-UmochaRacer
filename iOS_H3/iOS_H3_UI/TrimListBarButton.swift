//
//  TrimListBarButton.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/23.
//

import UIKit

final class TrimListBarButton: UIButton {

    enum Constants {
        static let selectedTintColor = UIColor.white
        static let selectedBackgroundColor = Colors.mainHyundaiBlue
        static let deselectedTintColor = Colors.coolGrey3
        static let deselectedBackgroundColor = Colors.coolGrey1
        static let checkedImageName = "icon_check_img"
        static let uncheckedImageName = "icon_uncheck_img"

        static let hashTagLabelTopOffset = 20.0
        static let hashTagLabelLeadingOffset = 20.0
        static let hashTagLabelHeight = 16.0
        static let trimTitleLabelTopOffset = 8.0
        static let trimTitleLabelHeight = 26.0
        static let checkImageViewTopOffset = 20.0
        static let checkImageViewTrailingOffset = 14.0
        static let checkImageViewSize = 24.0
    }

    // MARK: - UI properties

    private let hashTagLabel = UILabel()

    private let trimTitleLabel = UILabel()

    private let checkImageView = UIImageView()

    // MARK: - Properties

    private var trimCategory: TrimCategory {
        didSet {
            updateViewForCategory()
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkImageView.image = UIImage(named: Constants.checkedImageName)
                changeColor(tintColor: Constants.selectedTintColor, backgroundColor: Constants.selectedBackgroundColor)
            } else {
                checkImageView.image = UIImage(named: Constants.uncheckedImageName)
                changeColor(
                    tintColor: Constants.deselectedTintColor,
                    backgroundColor: Constants.deselectedBackgroundColor
                )
            }
        }
    }

    // MARK: - Lifecycles

    init(frame: CGRect, category: TrimCategory) {
        self.trimCategory = category
        super.init(frame: frame)
        setupUIProperties()
        setupViews()
    }

    override init(frame: CGRect) {
        trimCategory = .leBlanc
        super.init(frame: frame)
        setupUIProperties()
        setupViews()
    }

    required init?(coder: NSCoder) {
        trimCategory = .leBlanc
        super.init(coder: coder)
        setupUIProperties()
        setupViews()
    }

    // MARK: - Helpers

    func changeCategory(to newCategory: TrimCategory) {
        trimCategory = newCategory
    }

    func configureHashTagLabel(to text: String) {
        hashTagLabel.text = text
    }

    func configureTrimTitleLabel(to text: String) {
        trimTitleLabel.text = text
    }

    func changeColor(tintColor: UIColor, backgroundColor: UIColor) {
        hashTagLabel.textColor = tintColor
        trimTitleLabel.textColor = tintColor
        checkImageView.tintColor = tintColor
        self.backgroundColor = backgroundColor
    }

    private func updateViewForCategory() {
        configureHashTagLabel(to: trimCategory.hashTag)
        configureTrimTitleLabel(to: trimCategory.title)
    }
}

// MARK: - Setup

extension TrimListBarButton {

    // MARK: - Setup Views

    private func setupViews() {
        isSelected = false
        layer.cornerRadius = 6

        addSubviews()
        setupConstraints()
    }

    // MARK: - Setup UIProperties

    private func setupUIProperties() {
        setupHashTagLabel()
        setupTrimTitleLabel()
        setupCheckImageView()
    }

    private func setupHashTagLabel() {
        hashTagLabel.text = trimCategory.hashTag
        hashTagLabel.textColor = Constants.deselectedTintColor
        hashTagLabel.font = Fonts.regularBody3
        hashTagLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTrimTitleLabel() {
        trimTitleLabel.text = trimCategory.title
        trimTitleLabel.textColor = Constants.deselectedTintColor
        trimTitleLabel.font = Fonts.mediumTitle2
        trimTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupCheckImageView() {
        checkImageView.image = UIImage(named: Constants.uncheckedImageName)
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - AddSubviews

    private func addSubviews() {
        [hashTagLabel, trimTitleLabel, checkImageView].forEach { addSubview($0) }
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        setupHashTagLabelConstraints()
        setupTrimTitleLabelConstraints()
        setupCheckImageViewConstraints()
    }

    private func setupHashTagLabelConstraints() {
        NSLayoutConstraint.activate([
            hashTagLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.hashTagLabelTopOffset),
            hashTagLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.hashTagLabelLeadingOffset
            ),
            hashTagLabel.heightAnchor.constraint(equalToConstant: Constants.hashTagLabelHeight)
        ])
    }

    private func setupTrimTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            trimTitleLabel.topAnchor.constraint(
                equalTo: hashTagLabel.bottomAnchor,
                constant: Constants.trimTitleLabelTopOffset
            ),
            trimTitleLabel.leadingAnchor.constraint(equalTo: hashTagLabel.leadingAnchor),
            trimTitleLabel.heightAnchor.constraint(equalToConstant: Constants.trimTitleLabelHeight)
        ])
    }

    private func setupCheckImageViewConstraints() {
        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.checkImageViewTopOffset),
            checkImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: Constants.checkImageViewTrailingOffset
            ),
            checkImageView.heightAnchor.constraint(equalToConstant: Constants.checkImageViewSize),
            checkImageView.widthAnchor.constraint(equalToConstant: Constants.checkImageViewSize)
        ])
    }
}
