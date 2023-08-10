//
//  OptionMotionView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import UIKit
class OptionMotionView: UIView {

    private let smileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feedback_motion_face_first") ?? .remove
        return imageView
    }()

    private let goodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "feedback_motion_good_img") ?? .remove
        imageView.isHidden = true
        return imageView
    }()

    private let feedbackTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumTitle3
        label.text = "옵션 피드백 타이틀"
        label.textColor = .white
        return label
    }()

    private let feedbackDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularBody2
        label.text = "옵션 피드백 상세한 설명 타이틀"
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.layer.cornerRadius = 10

        self.addSubview(smileImageView)
        self.addSubview(goodImageView)
        self.addSubview(feedbackTitleLabel)
        self.addSubview(feedbackDescriptionLabel)

        smileImageView.translatesAutoresizingMaskIntoConstraints = false
        goodImageView.translatesAutoresizingMaskIntoConstraints = false
        feedbackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        feedbackDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        smileImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        smileImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        smileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        smileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        goodImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        goodImageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        goodImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 17).isActive = true
        goodImageView.leadingAnchor.constraint(equalTo: smileImageView.trailingAnchor, constant: 2).isActive = true

        feedbackTitleLabel.topAnchor.constraint(equalTo: smileImageView.bottomAnchor, constant: 6).isActive = true
        feedbackTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        feedbackTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true

        feedbackDescriptionLabel.topAnchor.constraint(equalTo: feedbackTitleLabel.bottomAnchor,
                                                      constant: 9).isActive = true
        feedbackDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18).isActive = true
        feedbackDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true

    }

    func showWithAnimation(title: String, description: String) {
        self.goodImageView.isHidden = true
        self.backgroundColor = Colors.mainHyundaiBlue
        smileImageView.image = UIImage(named: "feedback_motion_face_first") ?? .remove
        feedbackTitleLabel.text = title
        feedbackDescriptionLabel.text = description

        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.8, animations: {
                self.smileImageView.image = UIImage(named: "feedback_motion_face_second") ?? .remove
                self.goodImageView.isHidden = false
            })
        })
    }

}
