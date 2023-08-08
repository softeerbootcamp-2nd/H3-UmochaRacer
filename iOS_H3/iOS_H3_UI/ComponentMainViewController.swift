//
//  ViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/03.
//

import UIKit

class ComponentMainViewController: UIViewController {

    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 18
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy private var titleBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("네비게이션바 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapTitleBarButton), for: .touchUpInside)
        return button
    }()

    lazy private var optionCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("옵션카드버튼 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapOptionCardButton), for: .touchUpInside)
        return button
    }()

    lazy private var ohMyCarSetButton: UIButton = {
        let button = UIButton()
        button.setTitle("공통버튼 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapButtons), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()

    }

    func setupViews() {
        setupContainerView()
        setupUIComponentButtons()

    }

    func setupContainerView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                            constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }

    func setupUIComponentButtons() {
        stackView.addArrangedSubview(titleBarButton)
        stackView.addArrangedSubview(optionCardButton)
        stackView.addArrangedSubview(ohMyCarSetButton)

        let buttons = [titleBarButton, optionCardButton, ohMyCarSetButton]
        for button in buttons {
            button.widthAnchor.constraint(equalToConstant: 200).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }

    @objc func didTapTitleBarButton() {
        let titleBarVC = OhMyCarSetTitleBarViewController()
        self.present(titleBarVC, animated: false)
    }

    @objc func didTapOptionCardButton() {
        let titleBarVC = OptionCardButtonViewController()
        self.present(titleBarVC, animated: false)
    }

    @objc func didTapButtons() {
        let titleBarVC = OhMyCarSetButtonViewController()
        self.present(titleBarVC, animated: false)
    }

}
