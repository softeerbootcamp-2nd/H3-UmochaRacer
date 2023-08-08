//
//  OptionCardButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/05.
//

import Foundation
import UIKit

class OptionCardButton: UIButton {

    enum OptionCardType {
        case selfMode
        case guideMode
    }

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
    }

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
        label.font = Fonts.regularBody2
        label.textColor = Colors.coolGrey3
        return label
    }()
    private let optionTitleLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = Fonts.mediumTitle2
        label.textColor = Colors.coolGrey3
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.font = Fonts.regularBody2
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

    private var type: OptionCardType

    override init(frame: CGRect) {
        type = .selfMode
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        type = .selfMode
        super.init(coder: coder)
        setupUI()
    }

    init(type: OptionCardType,
         optionTitle: String = "옵션 타이틀",
         optionSubTitle: String = "옵션 서브 타이틀",
         price: String = "+ 0원") {
        self.type = type
        super.init(frame: .zero)
        self.optionTitleLabel.text = optionTitle
        self.optionSubTitleLabel.text = optionSubTitle
        self.priceLabel.text = price
        setupUI()
    }

    private func setupUI() {
        layout()
        attribute()
        updateButtonUI()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func updateButtonUI() {
        let selectedColors: UIColor?

        switch type {
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

    private func attribute() {
        self.layer.cornerRadius = 10
    }

    private func layout() {
        [checkImageView,
         optionTitleLabel,
         optionSubTitleLabel,
         priceLabel,
         tagListView
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        layoutCheckImageView() // 체크 이미지 Constraint 설정
        layoutOptionSubTitleLabel() // 서브 타이틀 Constraint 설정
        layoutOptionTitleLabel() // 타이틀 Constraint 설정
        layoutPriceLabel() // 가격 라벨 Constraint 설정
        layoutTagListView() // 태그 리스트 뷰 Constraint 설정
    }

    private func layoutCheckImageView() {
        checkImageView.widthAnchor.constraint(equalToConstant: Constants.checkImageViewWidth).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: Constants.checkImageViewWidth).isActive = true
        checkImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.checkImageViewTopAnchor).isActive = true
        checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func layoutOptionSubTitleLabel() {
        optionSubTitleLabel.topAnchor.constraint(equalTo: checkImageView.bottomAnchor,
                                                 constant: Constants.optionSubTitleTopAnchor).isActive = true
        optionSubTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func layoutOptionTitleLabel() {
        optionTitleLabel.topAnchor.constraint(equalTo: optionSubTitleLabel.bottomAnchor,
                                              constant: Constants.optionTitleTopAnchor).isActive = true
        optionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                  constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func layoutPriceLabel() {
        priceLabel.topAnchor.constraint(equalTo: optionTitleLabel.bottomAnchor,
                                        constant: Constants.priceLabelTopAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                            constant: Constants.checkImageViewLeadingAnchor).isActive = true
    }

    private func layoutTagListView() {
        tagListView.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: Constants.tagListViewTopAnchor).isActive = true
        tagListView.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor,
                                             constant: Constants.checkImageViewLeadingAnchor).isActive = true
        tagListView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                              constant: Constants.tagListViewTrailingAnchor).isActive = true
        tagListView.heightAnchor.constraint(equalToConstant: Constants.tagListViewHeight).isActive = true
    }

    // 옵션 타이틀을 변경하는 메서드
    func setOptionTitle(_ title: String) {
        self.optionTitleLabel.text = title
    }

    // 옵션 서브 타이틀을 변경하는 메서드
    func setOptionSubTitle(_ subTitle: String) {
        self.optionSubTitleLabel.text = subTitle
    }

    // 가격을 변경하는 메서드
    func setPrice(_ price: String) {
        self.priceLabel.text = price
    }

    // 여러 태그를 한 번에 추가하는 메서드
    func addTags(_ tags: [String]) {
        tagListView.addTags(tags)
    }

    // 외부에서 호출 가능한 애니메이션 메서드
    func animateButton(title: String, description: String) {
        self.addSubview(animatedView)
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        animatedView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        animatedView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        animatedView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        animatedView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        animatedView.showWithAnimation(title: title, description: description)
    }

    @objc func buttonTapped() {
        isSelected.toggle()
    }

}
