//
//  ViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/03.
//

import UIKit

class ComponentMainViewController: UIViewController {

    enum Constants {
        static let buttonHeight = 30.0
    }

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
        button.addTarget(self, action: #selector(didTapOhMyCarSetButton), for: .touchUpInside)
        return button
    }()

    lazy private var progressBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로그레스 바 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapProgressBarButton), for: .touchUpInside)
        return button
    }()

    lazy private var twoOptionCardButtonViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("TwoOptionCardButtonView 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapTwoOptionCardButtonViewButton), for: .touchUpInside)
        return button
    }()

    lazy private var bottomModalViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("하단모달창 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didBottomModalViewButton), for: .touchUpInside)
        return button
    }()

    lazy private var multiOptionCardButtonViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("MultiOptionCardButtonView 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapMultiOptionCardButtonViewButton), for: .touchUpInside)
        return button
    }()

    lazy private var carMakingContentViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("CarMakingContentViewButton 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapCarMakingContentViewButton), for: .touchUpInside)
        return button
    }()

	lazy private var optionCategoryTabbarButton: UIButton = {
        let button = UIButton()
        button.setTitle("OptionCategoryTabbar 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapOptionCategoryTabbarButton), for: .touchUpInside)
        return button
    }()

    lazy private var optionListModeButton: UIButton = {
        let button = UIButton()
        button.setTitle("optionListMode 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapOptionListModeButton), for: .touchUpInside)
        return button
    }()

    lazy private var textBoxButton: UIButton = {
        let button = UIButton()
        button.setTitle("textBox 보기", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapTextBoxButton), for: .touchUpInside)
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
        stackView.addArrangedSubview(progressBarButton)
        stackView.addArrangedSubview(twoOptionCardButtonViewButton)
        stackView.addArrangedSubview(bottomModalViewButton)
        stackView.addArrangedSubview(multiOptionCardButtonViewButton)
        stackView.addArrangedSubview(carMakingContentViewButton)
        stackView.addArrangedSubview(optionCategoryTabbarButton)
        stackView.addArrangedSubview(optionListModeButton)
        stackView.addArrangedSubview(textBoxButton)

        let buttons = [
            titleBarButton,
            optionCardButton,
            ohMyCarSetButton,
            progressBarButton,
            twoOptionCardButtonViewButton,
            bottomModalViewButton,
            multiOptionCardButtonViewButton,
            carMakingContentViewButton,
            optionCategoryTabbarButton,
            optionListModeButton,
            textBoxButton
        ]
        for button in buttons {
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        }
    }

    @objc func didTapTitleBarButton() {
        let viewController = OhMyCarSetTitleBarViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapOptionCardButton() {
        let viewController = OptionCardButtonViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapOhMyCarSetButton() {
        let viewController = OhMyCarSetButtonViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapProgressBarButton() {
        let viewController = CarMakingProgressBarViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapTwoOptionCardButtonViewButton() {
        let viewController = TwoOptionCardButtonViewController()
        self.present(viewController, animated: false)
    }

    @objc func didBottomModalViewButton() {
        let viewController = BottomModalViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapMultiOptionCardButtonViewButton() {
        let viewController = MultiOptionCardButtonViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapCarMakingContentViewButton() {
        let viewController = CarMakingContentViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false)
    }

    @objc func didTapOptionCategoryTabbarButton() {
        let viewController = OptionCategoryTabbarViewController()
        self.present(viewController, animated: false)
	}

    @objc func didTapOptionListModeButton() {
        let viewController = OptionListModeViewController()
        self.present(viewController, animated: false)
    }

    @objc func didTapTextBoxButton() {
        let viewController = TextBoxViewController()
        self.present(viewController, animated: false)
    }

}
