//
//  OhMyCarSetButtonViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/05.
//

import UIKit

final class OhMyCarSetButtonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupButtons()
    }

    private func setupButtons() {
        let mainBlueButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")
        mainBlueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainBlueButton)
        NSLayoutConstraint.activate([
            mainBlueButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainBlueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainBlueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainBlueButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        let whiteButton = OhMyCarSetButton(colorType: .white, title: "시승 신청하기")
        whiteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whiteButton)
        NSLayoutConstraint.activate([
            whiteButton.topAnchor.constraint(equalTo: mainBlueButton.bottomAnchor, constant: 10),
            whiteButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            whiteButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            whiteButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        let coolGreyButton = OhMyCarSetButton(colorType: .coolGrey1, title: "변경할래요!")
        coolGreyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coolGreyButton)
        NSLayoutConstraint.activate([
            coolGreyButton.topAnchor.constraint(equalTo: whiteButton.bottomAnchor, constant: 10),
            coolGreyButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            coolGreyButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            coolGreyButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        let greyButton = OhMyCarSetButton(colorType: .grey, title: "공유하기")
        greyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greyButton)
        NSLayoutConstraint.activate([
            greyButton.topAnchor.constraint(equalTo: coolGreyButton.bottomAnchor, constant: 10),
            greyButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            greyButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            greyButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        let disabledButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")
        disabledButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(disabledButton)
        NSLayoutConstraint.activate([
            disabledButton.topAnchor.constraint(equalTo: greyButton.bottomAnchor, constant: 10),
            disabledButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            disabledButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            disabledButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])
        disabledButton.isEnabled = false
    }
}
