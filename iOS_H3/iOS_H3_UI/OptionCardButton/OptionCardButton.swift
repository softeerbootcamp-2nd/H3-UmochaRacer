//
//  OptionCardButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/05.
//

import UIKit

protocol OptionCardButtonDelegate: AnyObject {
    func optionCardButtonMoreInfoButtonDidTap(
        _ optionCardButton: OptionCardButton,
        option: OptionCardInfo,
        step: CarMakingStep
    )
}

class OptionCardButton: UIButton {

    // MARK: - UI properties
    private struct Constants {
        static let checkImageViewWidth: CGFloat = 24
        static let checkImageViewTopAnchor: CGFloat = 24
        static let checkImageViewLeadingAnchor: CGFloat = 17
        static let optionSubTitleTopAnchor: CGFloat = 8
        static let optionTitleTopAnchor: CGFloat = 4
        static let priceLabelTopAnchor: CGFloat = 15
        static let tagListViewTopAnchor: CGFloat = 22
        static let tagListViewTrailingAnchor: CGFloat = -10
        static let tagListViewHeight: CGFloat = 20
        static let moreInfoButtonWidth: CGFloat = 18
        static let moreInfoButtonHeight: CGFloat = 18
        static let moreInfoButtonBottomMargin: CGFloat = -18
        static let moreInfoButtonTrailingMargin: CGFloat = -10
        static let optionImageViewWidth: CGFloat = 150
        static let optionImageViewHeight: CGFloat = 50
        static let optionImageViewCenterY: CGFloat = 15
        static let optionImageViewTrailingMargin: CGFloat = -18
        static let colorViewWidth: CGFloat = 60
        static let colorViewHeight: CGFloat = 60
        static let colorViewTrailingMargin: CGFloat = -28
    }

    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            updateButtonUI()
        }
    }

    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_uncheck_img") ?? .remove
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    private let optionSubTitleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = Fonts.regularBody3
        label.setupLineHeight(FontLineHeights.regularBody3)
        label.setupLetterSpacing(FontLetterSpacings.regularBody3)
        label.textColor = Colors.coolGrey3
        return label
    }()
    private let optionTitleLabel: URLabel = {
        let label = URLabel()
        label.isUserInteractionEnabled = false
        label.font = Fonts.mediumTitle2
        label.setupLineHeight(FontLineHeights.mediumTitle2)
        label.setupLetterSpacing(FontLetterSpacings.mediumTitle2)
        label.textColor = Colors.coolGrey3
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = Fonts.regularBody2
        label.setupLineHeight(FontLineHeights.regularBody2)
        label.setupLetterSpacing(FontLetterSpacings.regularBody2)
        label.textColor = Colors.coolGrey3
        return label
    }()

    private let tagListView: TagListView = {
        let view = TagListView()
        view.isUserInteractionEnabled = false
        return view
    }()

    private let animatedView: OptionMotionView = {
        let view = OptionMotionView()
        view.isHidden = true // 초기에 숨김
        return view
    }()

    private let moreInfoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_right_img") ?? .remove, for: .normal)
        button.isHidden = true
        return button
    }()

    private let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = .gray
        imageView.isHidden = true
        return imageView
    }()

    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 30
        view.isHidden = true
        return view
    }()

    private var carMakingMode: CarMakingMode
    private var step: CarMakingStep = .powertrain
    private var optionInfo: OptionCardInfo?

    weak var delegate: OptionCardButtonDelegate?

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        carMakingMode = .selfMode
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        carMakingMode = .selfMode
        super.init(coder: coder)
        setupViews()
    }

    init(carMakingMode: CarMakingMode, info: OptionCardInfo, step: CarMakingStep) {
        self.carMakingMode = carMakingMode
        self.optionInfo = info
        self.step = step
        super.init(frame: .zero)
        setupViews()
        update(carMakingMode: carMakingMode, cardInfo: info, step: step)
        addMoreInfoButtonTarget()
    }

    init(
         mode: CarMakingMode,
         optionTitle: String = "옵션 타이틀",
         optionSubTitle: String = "옵션 서브 타이틀",
         price: String = "+ 0원",
         hasMoreInfo: Bool = false,
         color: URColor? = nil,
         image: URL? = nil
    ) {
        self.carMakingMode = mode
        super.init(frame: .zero)
        self.optionTitleLabel.text = optionTitle
        self.optionSubTitleLabel.text = optionSubTitle
        self.priceLabel.text = price
        showMoreInfoButton(hasMoreInfo)
        setupViews()
        addMoreInfoButtonTarget()
        setColor(color)
        setImage(url: image)
    }

    // MARK: - Helpers
    func update(carMakingMode: CarMakingMode? = nil,
                cardInfo: OptionCardInfo? = nil,
                step: CarMakingStep) {
        if let carMakingMode = carMakingMode {
            self.carMakingMode = carMakingMode
        }
        self.step = step
        if let cardInfo = cardInfo {
            optionTitleLabel.urString = cardInfo.title
            self.optionTitleLabel.text = cardInfo.title.fullText
            self.optionSubTitleLabel.text = cardInfo.subTitle.fullText
            self.priceLabel.text = cardInfo.priceString
            self.optionInfo = cardInfo
            showMoreInfoButton(cardInfo.hasMoreInfo)
            isSelected = cardInfo.isSelected
            setColor(cardInfo.color)
            setImage(url: cardInfo.iconImageURL)
        }

        updateButtonUI()
    }

    func setColor(_ color: URColor?) {
        colorView.isHidden = color == nil ? true: false
        if let color {
            colorView.backgroundColor = UIColor(urColor: color)
        }
    }

    func setOptionTitle(_ title: String) {
        self.optionTitleLabel.text = title
    }

    func setOptionSubTitle(_ subTitle: String) {
        self.optionSubTitleLabel.text = subTitle
    }

    func setPrice(_ price: String) {
        self.priceLabel.text = price
    }

    func addTags(_ tags: [String]) {
        tagListView.addTags(tags)
    }

    func setImage(url: URL?) {
        optionImageView.isHidden = url == nil ? true: false
        if let url {
            optionImageView.loadCachedImage(of: url)
        }
    }

    func showMoreInfoButton(_ isShow: Bool) {
        moreInfoButton.isHidden = !isShow
    }

    func animateButton(with feedbackComment: FeedbackComment, completion: (() -> Void)? = nil) {
        animatedView.showWithAnimation(with: feedbackComment, completion: completion)
    }

    func resetAnimatedView() {
        animatedView.isHidden = true
    }
}

extension OptionCardButton {
    private func setupViews() {
        addSubViews()
        setupConstraints()
        updateButtonUI()
        self.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        self.layer.cornerRadius = 6
    }

    private func addSubViews() {
        [checkImageView,
         optionTitleLabel,
         optionSubTitleLabel,
         priceLabel,
         tagListView,
         moreInfoButton,
         optionImageView,
         colorView,
         animatedView
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func updateButtonUI() {
        let selectedColors: UIColor?

        switch carMakingMode {
        case .guideMode:
            selectedColors = Colors.subActiveBlue
        case .selfMode:
            selectedColors = Colors.mainHyundaiBlue
        }

        if isSelected {
            setAppearance(borderWidth: 2,
                          imageName: "icon_check_img",
                          tintColor: selectedColors ?? .red,
                          backgroundColor: .white,
                          textColor: selectedColors ?? .red)
            tagListView.isHidden = false
        } else {
            setAppearance(borderWidth: 0,
                          imageName: "icon_uncheck_img",
                          tintColor: Colors.coolGrey3,
                          backgroundColor: Colors.coolGrey1,
                          textColor: Colors.coolGrey3)

            tagListView.isHidden = true
        }
    }

    private func setAppearance(borderWidth: CGFloat,
                               imageName: String,
                               tintColor: UIColor?,
                               backgroundColor: UIColor,
                               textColor: UIColor) {
        self.layer.borderWidth = borderWidth
        checkImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) ?? .remove
        checkImageView.tintColor = tintColor
        self.layer.borderColor = tintColor?.cgColor
        self.backgroundColor = backgroundColor
        optionSubTitleLabel.textColor = textColor
        optionTitleLabel.textColor = textColor
        priceLabel.textColor = textColor
    }

    private func setupConstraints() {
        setupCheckImageViewConstraint()
        setupOptionSubTitleLabelConstraint()
        setupOptionTitleLabelConstraint()
        setupPriceLabelConstraint()
        setupTagListViewConstraint()
        setupMoreInfoButtonConstraint()
        setupImageViewConstraint()
        setupColorViewConstraint()
        setupAnimatedView()
    }

    private func setupCheckImageViewConstraint() {
        checkImageView.widthAnchor.constraint(equalToConstant: Constants.checkImageViewWidth).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: Constants.checkImageViewWidth).isActive = true
        checkImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.checkImageViewTopAnchor).isActive = true
        checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func setupOptionSubTitleLabelConstraint() {
        optionSubTitleLabel.topAnchor.constraint(equalTo: checkImageView.bottomAnchor,
                                                 constant: Constants.optionSubTitleTopAnchor).isActive = true
        optionSubTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func setupOptionTitleLabelConstraint() {
        optionTitleLabel.topAnchor.constraint(equalTo: optionSubTitleLabel.bottomAnchor,
                                              constant: Constants.optionTitleTopAnchor).isActive = true
        optionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func setupPriceLabelConstraint() {
        priceLabel.topAnchor.constraint(equalTo: optionTitleLabel.bottomAnchor,
                                        constant: Constants.priceLabelTopAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                            constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func setupTagListViewConstraint() {
        tagListView.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: Constants.tagListViewTopAnchor).isActive = true
        tagListView.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor,
                                             constant: Constants.checkImageViewLeadingAnchor).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                              constant: Constants.tagListViewTrailingAnchor).isActive = true
        tagListView.heightAnchor.constraint(equalToConstant: Constants.tagListViewHeight).isActive = true
    }

    private func setupMoreInfoButtonConstraint() {
        moreInfoButton.widthAnchor.constraint(equalToConstant: Constants.moreInfoButtonWidth).isActive = true
        moreInfoButton.heightAnchor.constraint(equalToConstant: Constants.moreInfoButtonHeight).isActive = true
        moreInfoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: Constants.moreInfoButtonBottomMargin).isActive = true
        moreInfoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: Constants.moreInfoButtonTrailingMargin).isActive = true
    }

    private func setupImageViewConstraint() {
        optionImageView.widthAnchor.constraint(equalToConstant: Constants.optionImageViewWidth).isActive = true
        optionImageView.heightAnchor.constraint(equalToConstant: Constants.optionImageViewHeight).isActive = true
        optionImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                                 constant: Constants.optionImageViewCenterY).isActive = true
        optionImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                  constant: Constants.optionImageViewTrailingMargin).isActive = true
    }

    private func setupColorViewConstraint() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.widthAnchor.constraint(equalToConstant: Constants.colorViewWidth).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: Constants.colorViewHeight).isActive = true
        colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: Constants.colorViewTrailingMargin).isActive = true
    }

    private func setupAnimatedView() {
        animatedView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animatedView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animatedView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        animatedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    private func addMoreInfoButtonTarget() {
        moreInfoButton.addTarget(self, action: #selector(moreInfoButtonTapped), for: .touchUpInside)
    }

    @objc
    private func optionButtonTapped() {
        isSelected.toggle()
    }

    @objc
    private func moreInfoButtonTapped() {
        if let optionInfo = optionInfo {
            delegate?.optionCardButtonMoreInfoButtonDidTap(self, option: optionInfo, step: self.step)
        }
    }
}
