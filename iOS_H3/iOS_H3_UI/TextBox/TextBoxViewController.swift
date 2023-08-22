//
//  TextBoxViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit

class TextBoxViewController: UIViewController {
    private var textBoxView: TextBoxView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextBoxView()
    }

    private func setupTextBoxView() {
        self.view.backgroundColor = .white
        textBoxView = TextBoxView()
        view.addSubview(textBoxView)
        textBoxView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textBoxView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])

        textBoxView.setText("백카(car)사전 용어 선택 및 번역 텍스트 표시 기능 구현 예제 헉스바리 줄이 초과 ")
        textBoxView.delegate = self
    }
}

extension TextBoxViewController: TextBoxViewDelegate {
    func didTapUnderstoodButton(in view: TextBoxView) {
        self.dismiss(animated: true)
    }
}
