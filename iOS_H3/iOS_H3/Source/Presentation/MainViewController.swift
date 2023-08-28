//
//  MainViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/24.
//

import UIKit

final class MainViewController: UIViewController {

    enum Constants {
        static let guideModeBackgroundImageName = "main_guideMode"
        static let leBlancBackgroundImageName = "main_leBlanc"
        static let guideModeImageRatio = 1220.0 / 375.0
        static let leBlancImageRatio = 2000.0 / 375.0

        static let titleBarHeight = 50.0
        static let titleURLabelTopOffset = 119.0
        static let titleURLabelLeadingOffset = 19.0
        static let titleURLabelHeight = 23.0

        static let trimListBarTopOffset = 22.0
        static let trimListBarHeight = 85.0

        static let selectCompletionButtonInset = 16.0
        static let selectCompletionButtonHeight = 56.0
        static let selectCompletionButtonBottomOffset = 5.0
    }

    // MARK: - UI properties

    private let scrollView = UIScrollView()

    private let titleBar = OhMyCarSetTitleBar(type: .main)

    private let titleURLabel = URLabel()

    private let trimListBar = TrimListBar()

    private let backgroundImageView = UIImageView()

    private let selectCompletionButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "선택완료")

    // MARK: - Properties

    private var selectedTrim = TrimCategory.guideMode

    private lazy var screenWidth = view.window?.windowScene?.screen.bounds.width ?? UIWindow().screen.bounds.size.width

    private lazy var imageViewHeightConstraint = backgroundImageView.heightAnchor.constraint(
        equalToConstant: screenWidth * Constants.guideModeImageRatio
    )

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTextEffectIfNeeded()
    }

    // MARK: - Helpers

    private func applyTextEffectIfNeeded() {
        let isOn = TextEffectManager.shared.isDictionaryFunctionActive
        if titleBar.isDictionaryButtonOn != isOn {
            titleBar.isDictionaryButtonOn = isOn
            TextEffectManager.shared.applyEffectSubviews(isOn, on: view)
        }
    }
}

// MARK: - OhMyCarSetTitleBar Delegate

extension MainViewController: OhMyCarSetTitleBarDelegate {
    func titleBarBackButtonPressed(_ titleBar: OhMyCarSetTitleBar) {
        print(#function)
    }

    func titleBarDictionaryButtonPressed(_ titleBar: OhMyCarSetTitleBar) {
        let isDictionaryOn = TextEffectManager.shared.isDictionaryFunctionActive
        TextEffectManager.shared.applyEffectSubviews(!isDictionaryOn, on: view)
    }
}

// MARK: - TrimListBar Delegate

extension MainViewController: TrimListBarDelegate {
    func trimListBarButtonDidTapped(didSelectItemAt index: Int) {
        guard let selectedTrim = TrimCategory(rawValue: index) else {
            return
        }
        self.selectedTrim = selectedTrim
        updateBackgroundImageForTrim()
    }

    private func updateBackgroundImageForTrim() {
        switch selectedTrim {
        case .guideMode:
            backgroundImageView.image = UIImage(named: Constants.guideModeBackgroundImageName)
            let height = screenWidth * Constants.guideModeImageRatio
            imageViewHeightConstraint.constant = height
        case .leBlanc:
            backgroundImageView.image = UIImage(named: Constants.leBlancBackgroundImageName)
            let height = screenWidth * Constants.leBlancImageRatio
            imageViewHeightConstraint.constant = height
        default:
            return
        }
    }
}

// MARK: - SetupViews

extension MainViewController {
    private func setupViews() {
        setupUIProperties()
        addSubviews()
        setupConstraints()
    }

    private func setupUIProperties() {
        setupScrollView()
        setupTitleBar()
        setupTitleLabel()
        setupTrimListBar()
        setupBackgroundImageView()
        setupSelectCompletionButton()
    }

    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTitleBar() {
        titleBar.delegate = self
        titleBar.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTitleLabel() {
        let titleText = "원하는 트림을 선택해주세요"
        titleURLabel.text = titleText
        titleURLabel.urString = URString(fullText: titleText, cardbRange: [(4..<7)])
        titleURLabel.font = Fonts.regularTitle3
        titleURLabel.applyBoldToString(targetString: "원하는 트림", font: Fonts.mediumTitle3 ?? .boldSystemFont(ofSize: 18))
        titleURLabel.textColor = Colors.coolGreyBlack
        titleURLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupTrimListBar() {
        trimListBar.trimListBarDelegate = self
        trimListBar.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: Constants.guideModeBackgroundImageName)
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupSelectCompletionButton() {
        selectCompletionButton.addTarget(
            self,
            action: #selector(selectCompletionButtonDidTapped(_:)),
            for: .touchUpInside
        )
        selectCompletionButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func selectCompletionButtonDidTapped(_ sender: UIButton) {
        let networkService = NetworkService()
        let carInfoRepository = CarInfoRepository(networkService: networkService)
        let introRepository = IntroRepository(networkService: networkService)
        let selfModeUsecase = SelfModeUsecase(carInfoRepository: carInfoRepository, introRepsitory: introRepository)
        let carMakingViewModel = CarMakingViewModel(selfModeUsecase: selfModeUsecase)
        let viewController = CarMakingViewController(mode: .selfMode, viewModel: carMakingViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        [backgroundImageView, titleBar, titleURLabel, trimListBar, selectCompletionButton].forEach {
            scrollView.addSubview($0)
        }
    }

    private func setupConstraints() {
        setupScrollViewConstraints()
        setupTitleBarConstraints()
        setupTitleLabelConstraints()
        setupTrimListBarConstraints()
        setupBackgroundImageViewConstraints()
        setupSelectCompletionButtonConstraints()
    }

    private func setupScrollViewConstraints() {
        let safeAreaInset = UIApplication.shared.windows[0].safeAreaInsets
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -safeAreaInset.top),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }

    private func setupTitleBarConstraints() {
        NSLayoutConstraint.activate([
            titleBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleBar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleBar.heightAnchor.constraint(equalToConstant: Constants.titleBarHeight)
        ])
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleURLabel.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: Constants.titleURLabelTopOffset
            ),
            titleURLabel.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constants.titleURLabelLeadingOffset
            ),
            titleURLabel.heightAnchor.constraint(equalToConstant: Constants.titleURLabelHeight)
        ])
    }

    private func setupTrimListBarConstraints() {
        NSLayoutConstraint.activate([
            trimListBar.topAnchor.constraint(
                equalTo: titleURLabel.bottomAnchor,
                constant: Constants.trimListBarTopOffset
            ),
            trimListBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            trimListBar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            trimListBar.heightAnchor.constraint(equalToConstant: Constants.trimListBarHeight)
        ])
    }

    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -Constants.selectCompletionButtonHeight
            ),
            imageViewHeightConstraint
        ])
    }

    private func setupSelectCompletionButtonConstraints() {
        NSLayoutConstraint.activate([
            selectCompletionButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.selectCompletionButtonBottomOffset
            ),
            selectCompletionButton.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constants.selectCompletionButtonInset
            ),
            selectCompletionButton.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -Constants.selectCompletionButtonInset
            ),
            selectCompletionButton.heightAnchor.constraint(equalToConstant: Constants.selectCompletionButtonHeight)
        ])
    }
}
