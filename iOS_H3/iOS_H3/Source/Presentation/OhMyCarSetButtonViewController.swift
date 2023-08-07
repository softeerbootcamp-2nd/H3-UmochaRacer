//
//  OhMyCarSetButtonViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/05.
//

import UIKit

final class OhMyCarSetButtonViewController: UIViewController {

    let mainBlueButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let whiteButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .white, title: "시승 신청하기")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let coolGreyButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .coolGrey1, title: "변경할래요!")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let greyButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .grey, title: "공유하기")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let disabledButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(mainBlueButton)
        view.addSubview(whiteButton)
        view.addSubview(coolGreyButton)
        view.addSubview(greyButton)
        view.addSubview(disabledButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainBlueButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainBlueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainBlueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainBlueButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            whiteButton.topAnchor.constraint(equalTo: mainBlueButton.bottomAnchor, constant: 10),
            whiteButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            whiteButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            whiteButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            coolGreyButton.topAnchor.constraint(equalTo: whiteButton.bottomAnchor, constant: 10),
            coolGreyButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            coolGreyButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            coolGreyButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            greyButton.topAnchor.constraint(equalTo: coolGreyButton.bottomAnchor, constant: 10),
            greyButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            greyButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            greyButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            disabledButton.topAnchor.constraint(equalTo: greyButton.bottomAnchor, constant: 10),
            disabledButton.leadingAnchor.constraint(equalTo: mainBlueButton.leadingAnchor),
            disabledButton.trailingAnchor.constraint(equalTo: mainBlueButton.trailingAnchor),
            disabledButton.heightAnchor.constraint(equalTo: mainBlueButton.heightAnchor)
        ])
    }
}
