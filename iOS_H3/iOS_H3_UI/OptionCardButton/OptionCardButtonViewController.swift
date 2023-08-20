//
//  OptionCardButtonViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import UIKit
class OptionCardButtonViewController: UIViewController {

    // 셀프모드 기본 버튼
    lazy var selfModeBasicButton: OptionCardButton = {
        let button = OptionCardButton(mode: .selfMode)
        return button
    }()

    // 가이드모드 자세히보기 버튼
    lazy var guideModeBasicButton: OptionCardButton = {
        let button = OptionCardButton(mode: .guideMode, hasMoreInfo: true)
        return button
    }()

    // 셀프모드 내장 색상 버튼
    lazy var selfModeInnerColorButton: OptionCardButton = {
        let button = OptionCardButton(mode: .selfMode)
        if let url = URL(string: "https://github.com/") {
            button.setImage(url: url)
        }
        return button
    }()

    // 셀프모드 외장 색상 버튼
    lazy var guideModeOuterColorButton: OptionCardButton = {
        let button = OptionCardButton(mode: .guideMode)
        button.setColor(URColor(red: 255, green: 167, blue: 36))
        return button
    }()

    lazy var animateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("옵션 선택 피드백 모션 실행", for: .normal)
        button.addTarget(self, action: #selector(animateButtons), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.tintColor = .black
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        layout()

        // 가격 변경하기
        self.guideModeBasicButton.setPrice("+ 1000원")

        // 타이틀 변경하기
        self.guideModeBasicButton.setOptionTitle("디젤 2.2")

        // 가격 변경하기
        self.guideModeBasicButton.setPrice("+ 3,456,789원")

        // 이미지 변경하기
//         self.selfModeInnerColorButton.setImage(UIImage(named: ""), for: .normal)

        // 컬러 변경하기
        self.guideModeOuterColorButton.setColor(URColor(red: 0, green: 0, blue: 0))
        // 태그 추가하기
        self.guideModeBasicButton.addTags(["효율 89%", "배터리 95%"])
        self.guideModeOuterColorButton.addTags(["효율 89%", "배터리 95%"])
    }

    private func layout() {
        view.addSubview(selfModeBasicButton)
        view.addSubview(guideModeBasicButton)
        view.addSubview(selfModeInnerColorButton)
        view.addSubview(guideModeOuterColorButton)
        selfModeBasicButton.translatesAutoresizingMaskIntoConstraints = false
        guideModeBasicButton.translatesAutoresizingMaskIntoConstraints = false
        selfModeInnerColorButton.translatesAutoresizingMaskIntoConstraints = false
        guideModeOuterColorButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            selfModeBasicButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            selfModeBasicButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selfModeBasicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selfModeBasicButton.heightAnchor.constraint(equalToConstant: 150),

            guideModeBasicButton.topAnchor.constraint(equalTo: self.selfModeBasicButton.bottomAnchor, constant: 16),
            guideModeBasicButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            guideModeBasicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            guideModeBasicButton.heightAnchor.constraint(equalToConstant: 150),

            selfModeInnerColorButton.topAnchor.constraint(equalTo: self.guideModeBasicButton.bottomAnchor,
                                                          constant: 16),
            selfModeInnerColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selfModeInnerColorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selfModeInnerColorButton.heightAnchor.constraint(equalToConstant: 150),

            guideModeOuterColorButton.topAnchor.constraint(equalTo: self.selfModeInnerColorButton.bottomAnchor,
                                                           constant: 16),
            guideModeOuterColorButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            guideModeOuterColorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            guideModeOuterColorButton.heightAnchor.constraint(equalToConstant: 150)
        ])

        // 애니메이션 테스트 버튼 추가
        view.addSubview(animateButton)
        animateButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            animateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            animateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // 애니메이션 테스트 버튼 액션
    @objc private func animateButtons() {
        self.selfModeBasicButton.animateButton(feedbackTitle: "디젤 엔진은 효율이 좋아요!", feedbackDescription: "효율을 중시한다면, 탁월한 선택입니다.")
        self.guideModeBasicButton.animateButton(feedbackTitle: "디젤 엔진은 효율이 좋아요!", feedbackDescription: "효율을 중시한다면, 탁월한 선택입니다.")
    }
}
