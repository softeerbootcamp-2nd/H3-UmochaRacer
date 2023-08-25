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

    private lazy var bottomModalView: BottomModalView = {
        let view = BottomModalView()
        view.delegate = self
        view.updateEstimatePrice(12345)
        return view
    }()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Helpers
}

extension BottomModalViewController: BottomModalViewDelegate {
    func bottomModalViewBackButtonDidTapped(_ bottomModalView: BottomModalView) {
        print("[BottomModalViewDelegate] 이전 버튼 클릭 시 액션 구현 필요")
    }

    func bottomModalViewCompletionButtonDidTapped(_ bottomModalView: BottomModalView) {
        print("[BottomModalViewDelegate] 선택완료 버튼 클릭 시 액션 구현 필요")
    }
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
