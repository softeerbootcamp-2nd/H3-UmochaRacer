//
//  TextBoxView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

protocol TextBoxViewDelegate: AnyObject {
    func didTapUnderstoodButton(in view: TextBoxView)
}

class TextBoxView: UIView {

    enum Constants {
        static let iconSize: CGFloat = 20
        static let leadingTrailingPadding: CGFloat = 20
        static let topPadding: CGFloat = 22
        static let iconTitleSpacing: CGFloat = 6
        static let titleButtonSpacing: CGFloat = 8
        static let buttonWidth: CGFloat = 73
        static let buttonHeight: CGFloat = 26
        static let dividerHeight: CGFloat = 1
        static let dividerTopPadding: CGFloat = 13
        static let textTopPadding: CGFloat = 27
        static let minimumTextLabelHeight: CGFloat = 90
    }

    // MARK: - UI properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dictionary_unselected_img")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이옵션은 뭔가요?"
        label.numberOfLines = 0
        label.font = Fonts.mediumTitle4
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .top
        label.textAlignment = .left
        return label
    }()

    lazy private var understoodButton: UIButton = {
        let button = UIButton()
        button.setTitle("이해했어요!", for: .normal)
        button.titleLabel?.font = Fonts.regularBody3
        button.backgroundColor = Colors.coolGrey4
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleUnderstoodButtonTap), for: .touchUpInside)
        return button
    }()

    private let divider: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = Colors.coolGrey4.cgColor
        return layer
    }()

    private let textLabel: TopAlignedLabel = {
        let label = TopAlignedLabel()
        label.setTextColor(.white)
        label.setFont(Fonts.regularBody2 ?? .systemFont(ofSize: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties
    weak var delegate: TextBoxViewDelegate?

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setDividerLayerFrame()
    }

    // MARK: - Helpers
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func updateText(_ text: String) {
        textLabel.setText(text)
    }

    @objc private func handleUnderstoodButtonTap() {
        delegate?.didTapUnderstoodButton(in: self)
    }
}

extension TextBoxView {
    private func setupView() {
        backgroundColor = Colors.coolGreyBlack
        layer.cornerRadius = 10

        [iconImageView,
         titleLabel,
         understoodButton,
         textLabel
        ]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                addSubview($0)
            }
        layer.addSublayer(divider)
        setConstraints()
    }

    private func setConstraints() {
        let minHeightConstraint = textLabel.heightAnchor
            .constraint(greaterThanOrEqualToConstant: Constants.minimumTextLabelHeight)
        minHeightConstraint.priority = .defaultHigh
        minHeightConstraint.isActive = true

        setIconImageViewConstraints()
        setTitleLabelConstraints()
        setUnderstoodButtonConstraints()
        setTextLabelConstraints()
    }

    private func setIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingTrailingPadding),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topPadding),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
    }

    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor,
                                                constant: Constants.iconTitleSpacing),
            titleLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: iconImageView.bottomAnchor)
        ])
    }

    private func setUnderstoodButtonConstraints() {
        NSLayoutConstraint.activate([
            understoodButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                                      constant: Constants.titleButtonSpacing),
            understoodButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Constants.leadingTrailingPadding),
            understoodButton.widthAnchor.constraint(equalToConstant: Constants.buttonWidth),
            understoodButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            understoodButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }

    private func setDividerLayerFrame() {
        let dividerX = Constants.leadingTrailingPadding
        let dividerWidth = bounds.width - 2 * Constants.leadingTrailingPadding
        let dividerHeight = Constants.dividerHeight
        let dividerY = titleLabel.frame.maxY + Constants.dividerTopPadding
        
        divider.frame = CGRect(x: dividerX, y: dividerY, width: dividerWidth, height: dividerHeight)
    }

    private func setTextLabelConstraints() {
        let minHeightConstraint = textLabel.heightAnchor
            .constraint(greaterThanOrEqualToConstant: Constants.minimumTextLabelHeight)
        minHeightConstraint.priority = .defaultHigh
        minHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingTrailingPadding),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leadingTrailingPadding),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.textTopPadding),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.leadingTrailingPadding)
        ])
    }
}
