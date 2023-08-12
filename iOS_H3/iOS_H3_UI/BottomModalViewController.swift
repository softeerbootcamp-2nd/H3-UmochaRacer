//
//  BottomModalViewController.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class BottomModalViewController: UIViewController {

    enum Constants {
        static let bottomModalViewHeight = 129.0
    }

    // MARK: - UI properties

    private let bottomModalView = BottomModalView()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Helpers
}

extension BottomModalViewController {

    private func setupViews() {
        view.backgroundColor = .white
        bottomModalView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(bottomModalView)
        NSLayoutConstraint.activate([
            bottomModalView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomModalView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomModalView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
