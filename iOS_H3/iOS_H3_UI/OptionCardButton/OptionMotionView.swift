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
        label.numberOfLines = .zero
        label.text = "옵션 피드백 타이틀"
        label.textColor = .white
        return label
    }()

    private let feedbackDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularBody2
        label.text = "옵션 피드백 상세한 설명 타이틀"
        label.textColor = .white
        label.numberOfLines = .zero
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
        smileImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        smileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        smileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        goodImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        goodImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
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

    func showWithAnimation(feedbackTitle: String, feedbackDescription: String, completion: (() -> Void)? = nil) {
        prepareViews(title: feedbackTitle, description: feedbackDescription)

        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        }, completion: { _ in
            self.performFirstAnimation(completion: {
                self.performSecondAnimation(completion: {
                    completion?()
                    self.hideGoodImageView()
                })
            })
        })
    }

    private func prepareViews(title: String, description: String) {
        goodImageView.isHidden = true
        backgroundColor = Colors.mainHyundaiBlue
        smileImageView.image = UIImage(named: "feedback_motion_face_first") ?? .remove
        feedbackTitleLabel.text = title
        feedbackDescriptionLabel.text = description
        alpha = 0.0
        isHidden = false
    }

    private func performFirstAnimation(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.7, animations: {
            self.smileImageView.image = UIImage(named: "feedback_motion_face_second") ?? .remove
            self.goodImageView.isHidden = false
        }, completion: { _ in
            completion()
        })
    }

    private func performSecondAnimation(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion()
        }
    }

    private func hideGoodImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.goodImageView.isHidden = false
            self.isHidden = true
        }
    }

}
