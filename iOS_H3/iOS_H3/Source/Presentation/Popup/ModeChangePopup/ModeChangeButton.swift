//
//  ModeChangeButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/27.
//

import UIKit

final class ModeChangeButton: UIButton {

    enum ButtonState {
        case inProgress
        case notInProgress

        var titleColor: UIColor {
            switch self {
            case .inProgress:
                return .black
            case .notInProgress:
                return UIColor.white
            }
        }

        var imageTintColor: UIColor {
            switch self {
            case .inProgress:
                return Colors.mainHyundaiBlue
            case .notInProgress:
                return UIColor.white
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .inProgress:
                return UIColor.white
            case .notInProgress:
                return Colors.subActiveBlue
            }
        }
    }

    // MARK: - UI Properties
    private let modeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.numberOfLines = 0
        label.font = Fonts.mediumTitle5
        label.isUserInteractionEnabled = false
        return label
    }()

    private let tagLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainHyundaiBlue
        label.text = "현재 진행중"
        label.font = Fonts.regularBody3
        label.backgroundColor = Colors.tagSkyBlue
        label.textAlignment = .center
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Fonts.regularBody2
        label.isUserInteractionEnabled = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = UIColor.blue
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    // MARK: - Properties
    var buttonState: ButtonState = .notInProgress {
        didSet {
            updateViewForState()
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Helpers

    func setModeTitle(_ text: String) {
        modeTitleLabel.text = text
    }

    func setDescription(_ text: String) {
        descriptionLabel.text = text
    }

    private func setupViews() {
        addSubview(modeTitleLabel)
        addSubview(tagLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)

        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1

        modeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            modeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            modeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            tagLabel.leadingAnchor.constraint(equalTo: modeTitleLabel.trailingAnchor, constant: 5),
            tagLabel.centerYAnchor.constraint(equalTo: modeTitleLabel.centerYAnchor),
            tagLabel.widthAnchor.constraint(equalToConstant: 68),
            tagLabel.heightAnchor.constraint(equalToConstant: 16),

            descriptionLabel.topAnchor.constraint(equalTo: modeTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),

            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            arrowImageView.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 10)
        ])
    }

    private func updateViewForState() {
        backgroundColor = buttonState.backgroundColor
        descriptionLabel.textColor = buttonState.titleColor
        modeTitleLabel.textColor = buttonState.imageTintColor
        arrowImageView.tintColor = buttonState.imageTintColor

        switch buttonState {
        case .inProgress:
            self.layer.borderColor = Colors.mainHyundaiBlue.cgColor
            self.layer.borderWidth = 1.0
        case .notInProgress:
            self.layer.borderWidth = 0
            self.tagLabel.isHidden = true
        }
    }
}
