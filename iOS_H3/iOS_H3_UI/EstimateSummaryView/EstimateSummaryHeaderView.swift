//
//  EstimateSummaryHeaderView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/20.
//

import UIKit

final class EstimateSummaryHeaderView: UICollectionReusableView {

    enum Constants {
        static let titleLabelTopOffset = 10.0
        static let labelSideOffset = 20.0
        static let labelHeight = 21.0
    }

    static let identifier = "EstimateSummaryHeaderView"

    // MARK: - UI properties

    private let titleLabel = UILabel()

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

    func configure(title: String, price: Int) {
        titleLabel.text = title
        priceLabel.text = "+ \(String.priceString(from: price))원"
    }
}

// MARK: - Setup Views

extension EstimateSummaryHeaderView {

    private func setupViews() {
        backgroundColor = Colors.coolGrey1
        setupUIProperties()
        addSubviews()
        setupConstraints()
    }

    // MARK: - Setup UIProperties

    private func setupUIProperties() {
        setupTitleLabel()
        setupPriceLabel()
    }

    private func setupTitleLabel() {
        titleLabel.font = Fonts.mediumTitle4
        titleLabel.text = "카테고리 타이틀"
        titleLabel.textColor = Colors.coolGreyBlack
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.mediumTitle4
        priceLabel.text = "+ 0원"
        priceLabel.textColor = Colors.mainHyundaiBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - AddSubviews

    private func addSubviews() {
        [titleLabel, priceLabel].forEach { addSubview($0) }
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.labelSideOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.labelSideOffset),
            priceLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }
}
