//
//  OhMyCarSetTitleBar.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/04.
//

import Foundation
import UIKit

protocol OhMyCarSetTitleBarDelegate: AnyObject {
    func backButtonPressed()
    func skipButtonPressed()
    func dictionaryButtonPressed()
    func changeModelButtonPressed()
    func titleButtonTapped()
}

class OhMyCarSetTitleBar: UIView {

    enum NavigationBarType {
        case onBoarding
        case main
        case selfMode
        case guideMode
    }

    enum Constants {
        static let stackViewLeadingConstant: CGFloat = 16
        static let stackViewTrailingConstant: CGFloat = -16
        static let stackViewSpacing: CGFloat = 12

    }

    weak var delegate: OhMyCarSetTitleBarDelegate?
    var isDictionaryButtonOn: Bool = false

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumTitle2
        label.setupLineHeight(FontLineHeights.mediumBody2)
        label.setupLetterSpacing(FontLetterSpacings.mediumBody2)
        return label
    }()

    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()

    var title: String? {
        didSet {
            self.titleLabel.text = self.title
            self.titleLogoButton.setTitle(self.title, for: .normal)
        }
    }

    private let titleLogoButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        let image = UIImage(named: "group_img")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = Colors.coolGreyBlack
        button.setImage(image, for: .normal)
        button.titleLabel?.font = Fonts.mediumTitle2
        button.titleLabel?.setupLineHeight(FontLineHeights.mediumTitle2)
        button.titleLabel?.setupLetterSpacing(FontLetterSpacings.mediumTitle2)
        return button
    }()

    var leftItems: [UIView] = [] {
        didSet {
            setLeftItems()
        }
    }

    var rightItems: [UIView] = [] {
        didSet {
            setRightItems()
        }
    }

    convenience init() {
        self.init(type: .onBoarding)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleLabel()
        configureType(.onBoarding)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setTitleLabel()
        configureType(.onBoarding)
    }

    init(type: NavigationBarType) {
        super.init(frame: .zero)
        setTitleLabel()
        configureType(type)
    }

    private func configureType(_ type: NavigationBarType) {
        switch type {
        case .onBoarding:
            self.title = ""
            self.leftItems = [createBackButton()]
            self.rightItems = [createSkipButton()]

        case .main:
            self.title = "내 차 만들기"
            self.leftItems = [createBackButton()]
            self.rightItems = [createDictionaryButton(), createChangeModelButton()]

        case .selfMode:
            self.title = "셀프 모드"
            self.leftItems = [createBackButton()]
            self.rightItems = [createDictionaryButton(), createChangeModelButton()]
            setTitleButton(title: "셀프모드")

        case .guideMode:
            self.title = "가이드 모드"
            self.leftItems = [createBackButton()]
            self.rightItems = [createDictionaryButton(), createChangeModelButton()]
            setTitleButton(title: "가이드 모드")
            titleLogoButton.setTitleColor(Colors.subActiveBlue, for: .normal)
            titleLogoButton.tintColor = Colors.subActiveBlue

        }
    }

    private func createBackButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_left_img"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }

    private func createSkipButton() -> UIButton {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(Colors.coolGrey3, for: .normal)

        button.titleLabel?.font = Fonts.regularBody2
        button.titleLabel?.setupLineHeight(FontLineHeights.regularBody2)
        button.titleLabel?.setupLetterSpacing(FontLetterSpacings.regularBody2)

        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }

    private func createDictionaryButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "dictionary_off_img"), for: .normal)
        button.addTarget(self, action: #selector(dictionaryButtonTapped), for: .touchUpInside)
        return button
    }

    private func createChangeModelButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "change_model_img"), for: .normal)
        button.addTarget(self, action: #selector(changeModelButtonTapped), for: .touchUpInside)
        return button
    }

    @objc private func backButtonTapped() {
        delegate?.backButtonPressed()
    }

    @objc private func skipButtonTapped() {
        delegate?.skipButtonPressed()
    }

    @objc private func dictionaryButtonTapped(_ sender: UIButton) {
        isDictionaryButtonOn.toggle()
        let buttonImage = isDictionaryButtonOn ? "dictionary_on_img" : "dictionary_off_img"
        sender.setImage(UIImage(named: buttonImage), for: .normal)
        delegate?.dictionaryButtonPressed()
    }

    @objc private func changeModelButtonTapped() {
        delegate?.changeModelButtonPressed()
    }
    @objc private func titleLogoButtonTapped() {
        delegate?.titleButtonTapped()
    }

    private func setTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.backgroundColor = .clear
    }

    private func setTitleButton(title: String) {
        titleLabel.isHidden = true

        self.addSubview(titleLogoButton)
        titleLogoButton.translatesAutoresizingMaskIntoConstraints = false

        titleLogoButton.sizeToFit()
        titleLogoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLogoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleLogoButton.titleLabel!.font!])
        let imageSize: CGFloat = titleLogoButton.imageView!.frame.size.width
        let spacing: CGFloat = 4
        titleLogoButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize + spacing / 2),
                                              bottom: 0, right: imageSize + spacing / 2)
        titleLogoButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing / 2,
                                              bottom: 0, right: -(titleSize.width + spacing / 2))

        titleLogoButton.addTarget(self, action: #selector(titleLogoButtonTapped), for: .touchUpInside)

    }

    private func setLeftItems() {
        let leftItems = leftItems

        self.addSubview(leftStackView)
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        leftStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftStackView.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor).isActive = true
        leftStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        leftStackView.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.leadingAnchor,
                                                constant: 12).isActive = true

        for item in leftItems {
            self.leftStackView.addArrangedSubview(item)
        }
    }

    private func setRightItems() {
         let leftItems = rightItems.reversed()

        self.addSubview(rightStackView)
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,
                                                constant: Constants.stackViewLeadingConstant).isActive = true
        rightStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightStackView.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor).isActive = true
        rightStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: Constants.stackViewTrailingConstant).isActive = true

        for item in leftItems.reversed() {
            self.rightStackView.addArrangedSubview(item)
        }
    }
}
