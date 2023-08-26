//
//  ModeChangeCheckPopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/27.
//

import UIKit

class ModeChangeCheckPopupViewController: UIViewController {
    // MARK: - UI properties
    @IBOutlet weak var popupTitleLabel: UILabel!

    @IBOutlet weak var popupDescriptionLabel: UILabel!

    @IBOutlet weak var changeButton: OhMyCarSetButton!

    @IBOutlet weak var cancelButton: OhMyCarSetButton!

    // MARK: - Properties

    var currentMode: CarMakingMode = .selfMode

    // MARK: - Lifecycles

    init(currentMode: CarMakingMode) {
        self.currentMode = currentMode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Helpers
    @IBAction func didTapChangeButton(_ sender: UIButton) {
        self.dismiss(animated: false) {
            if let navigationController = self.presentingViewController as? UINavigationController {
                navigationController.popViewController(animated: false)
            }
        }
    }

    @IBAction func didTapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension ModeChangeCheckPopupViewController {
    func setupView() {
        changeButton.changeColor(titleColor: Colors.mainHyundaiBlue, backgroundColor: Colors.coolGrey1)
        changeButton.titleLabel?.font = Fonts.mediumBody2
        changeButton.setTitle("변경할래요!", for: .normal)
        cancelButton.titleLabel?.font = Fonts.mediumBody2
        cancelButton.setTitle("안할래요", for: .normal)

        self.popupTitleLabel.font = Fonts.mediumTitle2
        self.popupTitleLabel.text = currentMode == .selfMode ? "[셀프모드]로 변경하시겠어요?" : "[가이드모드]로 변경하시겠어요?"
        self.popupDescriptionLabel.font = Fonts.regularBody2

    }

}
