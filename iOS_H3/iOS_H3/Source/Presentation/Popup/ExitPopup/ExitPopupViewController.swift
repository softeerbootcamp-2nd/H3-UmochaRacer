//
//  ExitPopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/27.
//

import UIKit

class ExitPopupViewController: UIViewController {

    // MARK: - UI properties
    @IBOutlet weak var popupTitleLabel: UILabel!

    @IBOutlet weak var popupDescriptionLabel: UILabel!

    @IBOutlet weak var exitButton: OhMyCarSetButton!

    @IBOutlet weak var cancelButton: OhMyCarSetButton!

    // MARK: - Properties

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Helpers
    @IBAction func didTapExitButton(_ sender: UIButton) {
        // 팝업 뷰 컨트롤러를 dismiss 하고 나서 popViewController를 호출
        self.dismiss(animated: true) {
            if let navigationController = self.presentingViewController as? UINavigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }

    @IBAction func didTapCancelButton(_ sender: UIButton) {
        // 팝업 뷰 컨트롤러만 dismiss
        self.dismiss(animated: true, completion: nil)
    }
}

extension ExitPopupViewController {
    func setupView() {
        exitButton.changeColor(titleColor: Colors.mainHyundaiBlue, backgroundColor: Colors.coolGrey1)
        exitButton.titleLabel?.font = Fonts.mediumBody2
        exitButton.setTitle("나갈래요", for: .normal)
        cancelButton.titleLabel?.font = Fonts.mediumBody2
        cancelButton.setTitle("나가지 않을래요!", for: .normal)

        self.popupTitleLabel.font = Fonts.mediumTitle2
        self.popupDescriptionLabel.font = Fonts.regularBody2

    }

}
