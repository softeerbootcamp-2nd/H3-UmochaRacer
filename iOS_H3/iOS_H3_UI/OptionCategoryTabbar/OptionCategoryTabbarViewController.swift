//
//  OptionCategoryTabbarViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/13.
//

import UIKit

class OptionCategoryTabbarViewController: UIViewController, UIScrollViewDelegate {
    let defaultButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "시스템")

    let selectedButton: OhMyCarSetButton = {
        let button = OhMyCarSetButton(colorType: .grey, title: "시스템")
        button.changeColor(titleColor: Colors.coolGrey3, backgroundColor: Colors.coolGrey1)
        button.isSelected = false
        return button
    }()

    let progressBar = OptionCategoryTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.tabBarDelegate = self

        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        defaultButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(defaultButton)
        defaultButton.sizeToFit()
        NSLayoutConstraint.activate([
            defaultButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            defaultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        selectedButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedButton)
        selectedButton.sizeToFit()
        NSLayoutConstraint.activate([
            selectedButton.topAnchor.constraint(equalTo: defaultButton.bottomAnchor, constant: 10),
            selectedButton.centerXAnchor.constraint(equalTo: defaultButton.centerXAnchor)
        ])

        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: selectedButton.bottomAnchor, constant: 10),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressBar.heightAnchor.constraint(equalTo: defaultButton.heightAnchor)
        ])
    }
}

extension OptionCategoryTabbarViewController: OptionCategoryTabBarDelegate {
    func tabBarButtonDidTapped(didSelectItemAt index: Int) {
        print("\(index) 선택")
    }
}
