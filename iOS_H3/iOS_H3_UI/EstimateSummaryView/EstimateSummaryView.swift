//
//  EstimateSummaryView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class EstimateSummaryView: UIScrollView {

    enum Constants {
        static let titleLabelTopOffset = 17.5
        static let labelSideOffset = 20.0
        static let labelHeight = 26.0
    }

    // MARK: - UI properties

    private let titleLabel = UILabel()

    private let priceLabel = UILabel()

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

    func configure(_ data: EstimateSummary) {
        print("[EstimateSummaryView]", #function, " \(data) // 메소드 구현 필요")
    }
}

// MARK: - Setup

extension EstimateSummaryView {

    private func setupViews() {
        setupUIProperties()
        addSubviews()
        setupConstraints()
    }

    private func setupUIProperties() {
        setupTitleLabel()
        setupPriceLabel()
    }

    private func addSubviews() {
        [titleLabel, priceLabel].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
    }

    private func setupTitleLabel() {
        titleLabel.font = Fonts.mediumTitle3
        titleLabel.text = "견적 요약"
        titleLabel.textColor = Colors.coolGreyBlack
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.mediumTitle2
        priceLabel.text = "0원"
        priceLabel.textColor = Colors.mainHyundaiBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
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
