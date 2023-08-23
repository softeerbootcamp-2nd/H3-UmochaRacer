//
//  TrimListBarViewController.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/23.
//

import UIKit

class TrimListBarViewController: UIViewController {

    let selectedLeBlancButton: TrimListBarButton = {
        let button = TrimListBarButton(frame: .zero, category: .leBlanc)
        button.isSelected = true
        return button
    }()

    let deselectedLeBlancButton: TrimListBarButton = {
        let button = TrimListBarButton(frame: .zero, category: .leBlanc)
        return button
    }()

//    let progressBar = CarMakingProgressBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        deselectedLeBlancButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deselectedLeBlancButton)
        NSLayoutConstraint.activate([
            deselectedLeBlancButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            deselectedLeBlancButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deselectedLeBlancButton.widthAnchor.constraint(equalToConstant: 200),
            deselectedLeBlancButton.heightAnchor.constraint(equalToConstant: 85)
        ])

        selectedLeBlancButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedLeBlancButton)
        selectedLeBlancButton.sizeToFit()
        NSLayoutConstraint.activate([
            selectedLeBlancButton.topAnchor.constraint(equalTo: deselectedLeBlancButton.bottomAnchor, constant: 10),
            selectedLeBlancButton.centerXAnchor.constraint(equalTo: deselectedLeBlancButton.centerXAnchor),
            selectedLeBlancButton.widthAnchor.constraint(equalToConstant: 200),
            selectedLeBlancButton.heightAnchor.constraint(equalToConstant: 85)
        ])

//        progressBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(progressBar)
//        NSLayoutConstraint.activate([
//            progressBar.topAnchor.constraint(equalTo: selectedLeBlancButton.bottomAnchor, constant: 10),
//            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            progressBar.heightAnchor.constraint(equalTo: deselectedLeBlancButton.heightAnchor)
//        ])
    }
}
