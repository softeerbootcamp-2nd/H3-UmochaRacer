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

    private lazy var trimListBar: TrimListBar = {
        let trimListBar = TrimListBar()
        trimListBar.trimListBarDelegate = self
        return trimListBar
    }()

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

        trimListBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trimListBar)
        NSLayoutConstraint.activate([
            trimListBar.topAnchor.constraint(equalTo: selectedLeBlancButton.bottomAnchor, constant: 10),
            trimListBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trimListBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trimListBar.heightAnchor.constraint(equalTo: deselectedLeBlancButton.heightAnchor)
        ])
    }
}

extension TrimListBarViewController: TrimListBarDelegate {
    func trimListBarButtonDidTapped(didSelectItemAt index: Int) {
        print("TrimLitsBar \(index)번 버튼 클릭")
    }
}
