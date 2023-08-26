//
//  ModelChangePopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/27.
//

import UIKit

class ModelChangePopupViewController: UIViewController {
    // MARK: - UI properties
    @IBOutlet weak var popupTitleLabel: UILabel!

    @IBOutlet weak var popupDescriptionLabel: UILabel!

    @IBOutlet weak var changeButton: OhMyCarSetButton!

    @IBOutlet weak var cancelButton: OhMyCarSetButton!

    // MARK: - Properties

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Helpers
    @IBAction func didTapChangeButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let navigationController = self.presentingViewController as? UINavigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }

    @IBAction func didTapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ModelChangePopupViewController {
    func setupView() {
        changeButton.changeColor(titleColor: Colors.mainHyundaiBlue, backgroundColor: Colors.coolGrey1)
        changeButton.titleLabel?.font = Fonts.mediumBody2
        changeButton.setTitle("변경할래요!", for: .normal)
        cancelButton.titleLabel?.font = Fonts.mediumBody2
        cancelButton.setTitle("안할래요", for: .normal)

        self.popupTitleLabel.font = Fonts.mediumTitle2
        self.popupDescriptionLabel.font = Fonts.regularBody2

    }

}
