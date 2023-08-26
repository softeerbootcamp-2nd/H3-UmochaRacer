//
//  ModeChangePopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/27.
//

import UIKit

class ModeChangePopupViewController: UIViewController {

    // MARK: - UI properties

    @IBOutlet weak var popupTitleLabel: UILabel!
    @IBOutlet weak var selfModeButton: ModeChangeButton!

    @IBOutlet weak var guideModeButton: ModeChangeButton!

    // MARK: - Properties

    var currentMode: CarMakingMode = .selfMode
    // MARK: - Lifecycles

    init(currentMode: CarMakingMode) {
        self.currentMode = currentMode
        super.init(nibName: nil, bundle: nil) // 뷰 컨트롤러가 스토리보드에서 로드되지 않는 경우
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    // MARK: - Helpers
    func setupView() {
        popupTitleLabel.font = Fonts.mediumTitle2
        popupTitleLabel.textColor = Colors.mainHyundaiBlue

        selfModeButton.setModeTitle("셀프 모드")
        selfModeButton.setDescription("가장 일반적으로 많은 사람들이 선택한\n인기있는 옵션들을 보며 내 취향에 맞게 자유롭게\n옵션을 선택할 수 있어요.")

        guideModeButton.setModeTitle("가이드 모드")
        guideModeButton.setDescription("내 상황과 성향에 맞는 옵션들을 추천받아\n나에게 딱 맞는 옵션들로 구성된 차량 견적을\n받아볼 수 있어요.")

        switch currentMode {
        case .selfMode:
            selfModeButton.buttonState = .inProgress
            guideModeButton.buttonState = .notInProgress
        case .guideMode:
            selfModeButton.buttonState = .notInProgress
            guideModeButton.buttonState = .inProgress
        }

        selfModeButton.addTarget(self, action: #selector(selfModeButtonTapped), for: .touchUpInside)
        guideModeButton.addTarget(self, action: #selector(guideModeButtonTapped), for: .touchUpInside)
    }

    @objc func selfModeButtonTapped() {
        if currentMode != .selfMode {
            presentOtherPopup(currentMode: .selfMode)
        } else {
            self.dismiss(animated: false)
        }
    }

    @objc func guideModeButtonTapped() {
        if currentMode != .guideMode {
            presentOtherPopup(currentMode: .guideMode)
        } else {
            self.dismiss(animated: false)
        }
    }

    func presentOtherPopup(currentMode: CarMakingMode) {
        let modeChangePopupVC = ModeChangeCheckPopupViewController(currentMode: currentMode)
        modeChangePopupVC.modalPresentationStyle = .overFullScreen
        let presentingVC = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingVC?.present(modeChangePopupVC, animated: false, completion: nil)
        })
    }
}
