//
//  EstimateSummaryCell.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/20.
//

import UIKit

final class EstimateSummaryCell: UICollectionViewCell {

    enum Constants {
        static let inset = 20.0
        static let carMakingStepLabelWidth = 70.0
        static let titleLabelLeadingOffset = 10.0
    }

    static let identifier = "EstimateSummaryCell"

    // MARK: - UI properties

    private let carMakingStepLabel = UILabel()

    private let optionTitleLabel = UILabel()

    private let priceLabel = UILabel()

    // MARK: - Properties

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Helpers
}

extension EstimateSummaryCell {
    
    private func setupViews() {
        setupUIProperties()
        addSubviews()
        setupConstraints()
    }
    
    private func setupUIProperties() {
        setupCarMakingStepLabel()
        setupOptionTitleLabel()
        setupPriceLabel()
    }
    
    private func addSubviews() {
        [carMakingStepLabel, optionTitleLabel, priceLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        setupCarMakingStepLabelConstraints()
        setupOptionTitleLabelConstraints()
        setupPriceLabelConstraints()
    }

    private func setupCarMakingStepLabel() {
        carMakingStepLabel.font = Fonts.regularBody2
        carMakingStepLabel.textColor = Colors.coolGrey3
        carMakingStepLabel.text = "카테고리"
        carMakingStepLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupOptionTitleLabel() {
        optionTitleLabel.font = Fonts.regularBody2
        optionTitleLabel.textColor = Colors.coolGreyBlack
        optionTitleLabel.text = "옵션 타이틀"
        optionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.regularBody2
        priceLabel.textColor = Colors.coolGreyBlack
        priceLabel.text = "0원"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupCarMakingStepLabelConstraints() {
        NSLayoutConstraint.activate([
            carMakingStepLabel.topAnchor.constraint(equalTo: topAnchor),
            carMakingStepLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.inset),
            carMakingStepLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            carMakingStepLabel.widthAnchor.constraint(equalToConstant: Constants.carMakingStepLabelWidth)
        ])
    }

    private func setupOptionTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            optionTitleLabel.topAnchor.constraint(equalTo: carMakingStepLabel.topAnchor),
            optionTitleLabel.leadingAnchor.constraint(equalTo: carMakingStepLabel.trailingAnchor, constant: Constants.titleLabelLeadingOffset),
            optionTitleLabel.bottomAnchor.constraint(equalTo: carMakingStepLabel.bottomAnchor)
        ])
    }

    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: carMakingStepLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.inset),
            priceLabel.bottomAnchor.constraint(equalTo: carMakingStepLabel.bottomAnchor)
        ])
    }
}
