//
//  BottomModalView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

protocol BottomModalViewDelegate: AnyObject {
    func bottomModalViewBackButtonDidTapped(_ bottomModalView: BottomModalView)
    func bottomModalViewCompletionButtonDidTapped(_ bottomModalView: BottomModalView)
}

final class BottomModalView: UIView {

    enum Constants {
        static let bottomModalViewHeight = 129.0

        static let cornerRadius = 16.0
        static let shadowColorHex = "8B8B8B"
        static let shadowHeight = 8.0
        static let shadowOpacity = 0.1

        static let modalHandleViewHeight = 21.0
        static let modalHandleSubLayerTopOffset = 8.0
        static let modalHandleSubLayerWidth = 40.0
        static let modalHandleSubLayerHeight = 5.0

        static let bottomContentViewHeight = 108.0
        static let bottomContentViewShadowOpacity = 0.7

        static let priceTitleLabelLeftOffset = 20.0
        static let priceTitleLabelTopOffset = 15.0
        static let priceTitleLabelWidth = 75.0
        static let priceTitleLabelHeight = 20.0

        static let priceLabelTopOffset = 4.0
        static let priceLabelRightOffset = 5.0
        static let priceLabelHeight = 29.0

        static let completionButtonTopOffset = 16.0
        static let completionButtonRightOffset = 27.0
        static let completionButtonWidth = 87.0
        static let completionButtonHeight = 50.0

        static let backButtonRightOffset = 32.0
    }

    // MARK: - UI properties

    private let modalHandleView = UIView()

    private let estimateSummaryView = EstimateSummaryView()

    private let bottomContentView = UIView()

    private let priceTitleLabel = UILabel()

    private let priceLabel = UILabel()

    private let backButton = OhMyCarSetButton()

    private let completionButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")

    private lazy var heightConstraint = heightAnchor.constraint(equalToConstant: Constants.bottomModalViewHeight)

    // MARK: - Properties

    weak var delegate: BottomModalViewDelegate!

    private var isShowingEstimateSummaryView: Bool = false {
        didSet {
            if isShowingEstimateSummaryView {
                showEstimateSummaryView()
            } else {
                hideEstimateSummaryView()
            }
        }
    }

    private lazy var screenSize = window?.windowScene?.screen.bounds.size ?? UIWindow().screen.bounds.size

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

    func updateEstimatePrice(_ price: Int) {
        priceLabel.text = "\(String.priceString(from: price)) 원"
    }

    func updateEstimateSummary(_ estimateSummary: EstimateSummary) {
        estimateSummaryView.configure(estimateSummary)
    }
}

// MARK: - Setup

extension BottomModalView {

    // MARK: - Setup Properties

    private func setupProperties() {
        setupModalHandleView()
        setupEstimateSummaryView()
        setupBottomContentView()
        setupPriceTitleLabel()
        setupPriceLabel()
        setupBackButton()
        setupCompletionButton()
    }

    private func setupModalHandleView() {
        modalHandleView.backgroundColor = .white
        modalHandleView.translatesAutoresizingMaskIntoConstraints = false
        addTapGestureToModalHandleView()
        addModalHandleSubLayer()
    }

    private func setupEstimateSummaryView() {
        estimateSummaryView.backgroundColor = .white
        estimateSummaryView.isHidden = true
        estimateSummaryView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBottomContentView() {
        bottomContentView.backgroundColor = .white
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
        backButton.addTarget(self, action: #selector(backButtonDidTapped), for: .touchUpInside)
    }

    private func setupCompletionButton() {
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        completionButton.addTarget(self, action: #selector(completionButtonDidTapped), for: .touchUpInside)
    }

    private func addTapGestureToModalHandleView() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(modalHandleViewDidTapped))
        modalHandleView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func modalHandleViewDidTapped() {
        isShowingEstimateSummaryView.toggle()
    }

    private func showEstimateSummaryView() {
        estimateSummaryView.isHidden = false
        bottomContentView.layer.shadowOpacity = Float(Constants.bottomContentViewShadowOpacity)

        let viewHeight = screenSize.height * 3 / 4
        updateHeightConstraint(viewHeight)
    }

    private func hideEstimateSummaryView() {
        estimateSummaryView.isHidden = true
        bottomContentView.layer.shadowOpacity = 0
        updateHeightConstraint(Constants.bottomModalViewHeight)
    }

    private func updateHeightConstraint(_ height: CGFloat) {
        heightConstraint.constant = height
        layoutIfNeeded()
    }

    private func addModalHandleSubLayer() {
        let subLayer = CALayer()
        subLayer.frame = CGRect(
            x: (screenSize.width - Constants.modalHandleSubLayerWidth) / 2,
            y: Constants.modalHandleSubLayerTopOffset,
            width: Constants.modalHandleSubLayerWidth,
            height: Constants.modalHandleSubLayerHeight
        )
        subLayer.backgroundColor = Colors.coolGrey3.cgColor
        modalHandleView.layer.addSublayer(subLayer)
    }

    @objc
    private func backButtonDidTapped() {
        delegate.bottomModalViewBackButtonDidTapped(self)
    }

    @objc
    private func completionButtonDidTapped() {
        delegate.bottomModalViewCompletionButtonDidTapped(self)
    }

    // MARK: - Setup Views

    private func setupViews() {
        setupTopCornerRadius()
        setupShawdow()
        setupBottomContentViewShadow()
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

    private func setupBottomContentViewShadow() {
        bottomContentView.layer.shadowColor = UIColor.white.cgColor
        bottomContentView.layer.shadowOffset = CGSize(width: 0, height: -Constants.shadowHeight * 2)
        bottomContentView.layer.shadowOpacity = 0
    }

    private func addSubviews() {
        addSubview(modalHandleView)
        addSubview(estimateSummaryView)
        addSubview(bottomContentView)
        bottomContentView.addSubview(priceTitleLabel)
        bottomContentView.addSubview(priceLabel)
        bottomContentView.addSubview(backButton)
        bottomContentView.addSubview(completionButton)
    }

    private func setupConstraints() {
        heightConstraint.isActive = true
        setupModalHandleViewConstraints()
        setupEstimateSummaryViewConstraints()
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

    private func setupEstimateSummaryViewConstraints() {
        NSLayoutConstraint.activate([
            estimateSummaryView.topAnchor.constraint(equalTo: modalHandleView.bottomAnchor),
            estimateSummaryView.leadingAnchor.constraint(equalTo: modalHandleView.leadingAnchor),
            estimateSummaryView.trailingAnchor.constraint(equalTo: modalHandleView.trailingAnchor),
            estimateSummaryView.bottomAnchor.constraint(equalTo: bottomContentView.topAnchor)
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
                constant: Constants.priceTitleLabelLeftOffset
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
            priceLabel.leadingAnchor.constraint(equalTo: priceTitleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(
                equalTo: backButton.leadingAnchor,
                constant: -Constants.priceLabelRightOffset
            ),
            priceLabel.heightAnchor.constraint(equalToConstant: Constants.priceLabelHeight)
        ])
    }

    private func setupBackButtonConstraints() {
        backButton.sizeToFit()
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: completionButton.centerYAnchor
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
                constant: -Constants.completionButtonRightOffset
            ),
            completionButton.widthAnchor.constraint(equalToConstant: Constants.completionButtonWidth),
            completionButton.heightAnchor.constraint(equalToConstant: Constants.completionButtonHeight)
        ])
    }
}
