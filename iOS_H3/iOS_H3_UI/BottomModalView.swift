//
//  BottomModalView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class BottomModalView: UIView {

    enum Constants {
        static let cornerRadius = 16.0
        static let shadowColorHex = "8B8B8B"
        static let shadowHeight = 8.0
        static let shadowOpacity = 0.1

        static let modalHandleViewHeight = 21.0
        static let modalHandleSubLayerTopOffset = 8.0
        static let modalHandleSubLayerWidth = 40.0
        static let modalHandleSubLayerHeight = 5.0
        static let bottomContentViewHeight = 108.0
        static let leadingInset = 20.0
        static let trailingInset = 27.0
        static let priceTitleLabelTopOffset = 15.0
        static let priceTitleLabelWidth = 75.0
        static let priceTitleLabelHeight = 20.0
        static let priceLabelTopOffset = 4.0
        static let priceLabelRightOffset = 5.0
        static let priceLabelHeight = 29.0
        static let completionButtonTopOffset = 16.0
        static let completionButtonWidth = 87.0
        static let completionButtonHeight = 50.0
        static let backButtonRightOffset = 32.0
    }

    // MARK: - UI properties

    private let modalHandleView = UIView()

    private let bottomContentView = UIView()

    private let priceTitleLabel = UILabel()

    private let priceLabel = UILabel()

    private let backButton = OhMyCarSetButton()

    private let completionButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupProperties()
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupProperties()
        setupViews()
    }

    // MARK: - Helpers

}

// MARK: - Setup

extension BottomModalView {

    // MARK: - Setup Properties

    private func setupProperties() {
        setupModalHandleView()
        setupBottomContentView()
        setupPriceTitleLabel()
        setupPriceLabel()
        setupBackButton()
        setupCompletionButton()
    }

    private func setupModalHandleView() {
        modalHandleView.translatesAutoresizingMaskIntoConstraints = false
        addTapGestureToModalHandleView()
        addModalHandleSubLayer()
    }

    private func setupBottomContentView() {
        bottomContentView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceTitleLabel() {
        priceTitleLabel.text = "총 견적금액"
        priceTitleLabel.font = Fonts.mediumBody2
        priceTitleLabel.setupLineHeight(FontLineHeights.mediumBody2)
        priceTitleLabel.textColor = Colors.coolGrey3
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceLabel() {
        priceLabel.text = "43,460,000 원"
        priceLabel.font = Fonts.mediumTitle1
        priceLabel.setupLineHeight(FontLineHeights.mediumTitle1)
        priceLabel.textColor = Colors.coolGreyBlack
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBackButton() {
        backButton.changeColor(titleColor: Colors.coolGrey3, backgroundColor: .white)
        backButton.setTitle("이전", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupCompletionButton() {
        completionButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addTapGestureToModalHandleView() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(modalHandleViewDidTapped))
        modalHandleView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func modalHandleViewDidTapped() {
        print(#function)
    }

    private func addModalHandleSubLayer() {
        let subLayer = CALayer()
        let fullWidth = window?.windowScene?.screen.bounds.width ?? UIWindow().screen.bounds.width
        subLayer.frame = CGRect(
            x: (fullWidth - Constants.modalHandleSubLayerWidth) / 2,
            y: Constants.modalHandleSubLayerTopOffset,
            width: Constants.modalHandleSubLayerWidth,
            height: Constants.modalHandleSubLayerHeight
        )
        subLayer.backgroundColor = Colors.coolGrey3.cgColor
        modalHandleView.layer.addSublayer(subLayer)
    }

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .white
        setupTopCornerRadius()
        setupShawdow()
        addSubviews()
        setupConstraints()
    }

    private func setupTopCornerRadius() {
        layer.cornerRadius = Constants.cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    private func setupShawdow() {
        layer.shadowColor = (UIColor(hex: Constants.shadowColorHex) ?? .black).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -Constants.shadowHeight * 2)
        layer.shadowOpacity = Float(Constants.shadowOpacity)
        layer.shadowRadius = Constants.cornerRadius
    }

    private func addSubviews() {
        addSubview(modalHandleView)
        addSubview(bottomContentView)
        bottomContentView.addSubview(priceTitleLabel)
        bottomContentView.addSubview(priceLabel)
        bottomContentView.addSubview(backButton)
        bottomContentView.addSubview(completionButton)
    }

    private func setupConstraints() {
        setupModalHandleViewConstraints()
        setupBottomContentViewConstraints()
        setupPriceTitleLabelConstraints()
        setupPriceLabelConstraints()
        setupBackButtonConstraints()
        setupCompletionButtonConstraints()
    }

    private func setupModalHandleViewConstraints() {
        NSLayoutConstraint.activate([
            modalHandleView.topAnchor.constraint(equalTo: self.topAnchor),
            modalHandleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modalHandleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            modalHandleView.heightAnchor.constraint(equalToConstant: Constants.modalHandleViewHeight)
        ])
    }

    private func setupBottomContentViewConstraints() {
        NSLayoutConstraint.activate([
            bottomContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomContentView.heightAnchor.constraint(equalToConstant: Constants.bottomContentViewHeight)
        ])
    }

    private func setupPriceTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            priceTitleLabel.topAnchor.constraint(
                equalTo: bottomContentView.topAnchor,
                constant: Constants.priceTitleLabelTopOffset
            ),
            priceTitleLabel.leadingAnchor.constraint(
                equalTo: bottomContentView.leadingAnchor,
                constant: Constants.leadingInset
            ),
            priceTitleLabel.widthAnchor.constraint(equalToConstant: Constants.priceTitleLabelWidth),
            priceTitleLabel.heightAnchor.constraint(equalToConstant: Constants.priceTitleLabelHeight)
        ])
    }

    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(
                equalTo: priceTitleLabel.bottomAnchor,
                constant: Constants.priceLabelTopOffset
            ),
            priceLabel.leadingAnchor.constraint(
                equalTo: priceTitleLabel.leadingAnchor
            ),
            priceLabel.trailingAnchor.constraint(
                equalTo: backButton.leadingAnchor,
                constant: -Constants.priceLabelRightOffset
            ),
            priceLabel.heightAnchor.constraint(
                equalToConstant: Constants.priceLabelHeight
            )
        ])
    }

    private func setupBackButtonConstraints() {
        backButton.sizeToFit()
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(
                equalTo: completionButton.centerYAnchor
            ),
            backButton.trailingAnchor.constraint(
                equalTo: completionButton.leadingAnchor,
                constant: -Constants.backButtonRightOffset
            )
        ])
    }

    private func setupCompletionButtonConstraints() {
        NSLayoutConstraint.activate([
            completionButton.topAnchor.constraint(
                equalTo: bottomContentView.topAnchor,
                constant: Constants.completionButtonTopOffset
            ),
            completionButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -Constants.trailingInset
            ),
            completionButton.widthAnchor.constraint(
                equalToConstant: Constants.completionButtonWidth
            ),
            completionButton.heightAnchor.constraint(
                equalToConstant: Constants.completionButtonHeight
            )
        ])
    }
}