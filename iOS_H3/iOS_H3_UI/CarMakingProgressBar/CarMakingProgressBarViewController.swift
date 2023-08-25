//
//  CarMakingProgressBarViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import UIKit

class CarMakingProgressBarViewController: UIViewController {

    let selectedButton = CarMakingProgressBarButton(title: "01 파워트레인")

    let defaultButton: CarMakingProgressBarButton = {
        let button = CarMakingProgressBarButton(title: "02 구동방식")
        button.isSelected = true
        return button
    }()

    let progressBar = CarMakingProgressBar()

    override func viewDidLoad() {
        super.viewDidLoad()

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
