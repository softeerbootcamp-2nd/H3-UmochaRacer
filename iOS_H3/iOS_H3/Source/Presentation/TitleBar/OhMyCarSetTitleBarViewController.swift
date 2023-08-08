//
//  OhMyCarSetTitleBarViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/05.
//

import Foundation
import UIKit
class OhMyCarSetTitleBarViewController: UIViewController {

    lazy var onboardingBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .onBoarding)
        titleBar.delegate = self
        return titleBar
    }()

    lazy var mainBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .main)
        titleBar.delegate = self
        return titleBar
    }()

    lazy var selfModeBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .selfMode)
        titleBar.delegate = self
        return titleBar
    }()

    lazy var guideModeBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .guideMode)
        titleBar.delegate = self
        return titleBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(onboardingBar)
        self.view.addSubview(mainBar)
        self.view.addSubview(selfModeBar)
        self.view.addSubview(guideModeBar)

        setLayoutConstraints()
    }

    private func setLayoutConstraints() {
        onboardingBar.translatesAutoresizingMaskIntoConstraints = false
        mainBar.translatesAutoresizingMaskIntoConstraints = false
        selfModeBar.translatesAutoresizingMaskIntoConstraints = false
        guideModeBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            onboardingBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
            onboardingBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            onboardingBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            onboardingBar.heightAnchor.constraint(equalToConstant: 50),

            mainBar.topAnchor.constraint(equalTo: onboardingBar.bottomAnchor, constant: 0),
            mainBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainBar.heightAnchor.constraint(equalToConstant: 50),

            selfModeBar.topAnchor.constraint(equalTo: mainBar.bottomAnchor, constant: 0),
            selfModeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            selfModeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            selfModeBar.heightAnchor.constraint(equalToConstant: 50),

            guideModeBar.topAnchor.constraint(equalTo: selfModeBar.bottomAnchor, constant: 0),
            guideModeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            guideModeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            guideModeBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension OhMyCarSetTitleBarViewController: OhMyCarSetTitleBarDelegate {
    func titleButtonTapped() {
        print("titleButton Pressed")
    }

    func backButtonPressed() {
        print("backButton Pressed")
    }

    func skipButtonPressed() {
        print("skipButton Pressed")
    }

    func dictionaryButtonPressed() {
        print("dictionaryButton Pressed")
    }

    func changeModelButtonPressed() {
        print("changeModelButton Pressed")
    }
}
