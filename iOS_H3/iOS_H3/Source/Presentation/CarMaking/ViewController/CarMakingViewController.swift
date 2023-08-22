//
//  CarMakingViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/15.
//

import UIKit
import Combine

final class CarMakingViewController: UIViewController {

    enum Constants {
        static let titleBarHeight = 50.0
        static let bottomModalViewHeight = 129.0
    }

    // MARK: - UI properties

    private var titleBar: OhMyCarSetTitleBar!

    private var carMakingContentView: CarMakingContentView<PageSection>!

    private let bottomModalView = BottomModalView()

    // MARK: - Properties

    private let mode: CarMakingMode

    private let viewModel: CarMakingViewModel

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()

    private let stepDidChanged = CurrentValueSubject<CarMakingStep, Never>(.powertrain)

    private let optionDidSelected = PassthroughSubject<(step: CarMakingStep, optionIndex: Int), Never>()

    private let optionCategoryDidChanged = CurrentValueSubject<OptionCategoryType, Never>(.system)

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycles

    init(mode: CarMakingMode, viewModel: CarMakingViewModel) {
        self.viewModel = viewModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.mode = .selfMode
        self.viewModel = CarMakingViewModel(
            selfModeUsecase: SelfModeUsecase(
                carInfoRepository: CarInfoRepository(networkService: NetworkService()),
                introRepsitory: IntroRepository(networkService: NetworkService())
            )
        )
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProperties()
        setupViews()
        bind()
        viewDidLoadSubject.send(())
    }

    // MARK: - Helpers
}

// MARK: - binding with ViewModel

extension CarMakingViewController {

    private func bind() {
        let input = CarMakingViewModel.Input(
            viewDidLoad: viewDidLoadSubject,
            carMakingStepDidChanged: stepDidChanged,
            optionDidSelected: optionDidSelected,
            optionCategoryDidChanged: optionCategoryDidChanged
        )
        let output = viewModel.transform(input)

        output.estimateSummary
            .receive(on: DispatchQueue.main)
            .sink { [weak self] summary in
                self?.updateBottomModalView(with: summary)
            }
            .store(in: &cancellables)

        output.currentStepInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] info in
                self?.updateCurrentStepInfo(with: info)
            }
            .store(in: &cancellables)

        output.optionInfoDidUpdated
            .sink { [weak self] optionInfo in
                self?.carMakingContentView.updateOptionCard(with: optionInfo)
            }
            .store(in: &cancellables)

        output.optionInfoForCategory
            .receive(on: DispatchQueue.main)
            .sink { [weak self] optionInfo in
                self?.carMakingContentView.updateOptionCardForCategory(with: optionInfo)
            }
            .store(in: &cancellables)

        output.showIndicator
            .sink { [weak self] showIndicator in
                self?.showIndicator(showIndicator)
            }
            .store(in: &cancellables)
    }

    private func updateBottomModalView(with estimateData: EstimateSummary) {
        // 총 견적금액 계산해서 bottomModalView.updateEstimatePrice(price) 호출
        bottomModalView.updateEstimateSummary(estimateData)
    }

    private func updateCurrentStepInfo(with info: CarMakingStepInfo) {
        carMakingContentView.configureCurrentStep(with: info)
    }

    private func showIndicator(_ show: Bool) {
        if show {
            view.showLoadingIndicator()
        } else {
            view.hideLoadingIndicator()
        }
    }
}

// MARK: - OhMyCarSetTitleBar Delegate

extension CarMakingViewController: OhMyCarSetTitleBarDelegate {

    func titleBarBackButtonPressed(_ titleBar: OhMyCarSetTitleBar) {
        print("[CarMakingViewController]", #function, "백버튼 클릭 액션 구현 필요")
    }

    func titleBarTitleButtonTapped(_ titleBar: OhMyCarSetTitleBar) {
        print("[CarMakingViewController]", #function, "title 버튼 클릭 액션 구현 필요")
    }

    func titleBarDictionaryButtonPressed(_ titleBar: OhMyCarSetTitleBar) {
        print("[CarMakingViewController]", #function, "백카사전 버튼 클릭 액션 구현 필요")
    }

    func titleBarChangeModelButtonPressed(_ titleBar: OhMyCarSetTitleBar) {
        print("[CarMakingViewController]", #function, "모드변경 버튼 클릭 액션 구현 필요")
    }
}

// MARK: - CarMakingContentView Delegate

extension CarMakingViewController: CarMakingContentViewDelegate {

    func carMakingContentView(stepDidChanged stepIndex: Int) {
        if let step = CarMakingStep(rawValue: stepIndex) {
            stepDidChanged.send(step)
        }
    }

    func carMakingContentView(optionDidSelectedAt optionIndex: Int, in stepIndex: Int) {
        if let step = CarMakingStep(rawValue: stepIndex) {
            optionDidSelected.send((step, optionIndex))
        }
    }

    func carMakingContentView(categoryDidSelected category: OptionCategoryType) {
        optionCategoryDidChanged.send(category)
    }
}

// MARK: - BottomModalView Delegate

extension CarMakingViewController: BottomModalViewDelegate {

    func bottomModalViewBackButtonDidTapped(_ bottomModalView: BottomModalView) {
        carMakingContentView.movePrevStep()
    }

    func bottomModalViewCompletionButtonDidTapped(_ bottomModalView: BottomModalView) {

        carMakingContentView.moveNextStep(feedbackTitle: viewModel.feedbackTitle,
                                          feedbackDescription: viewModel.feedbackDescription)
    }
}

// MARK: - Setup Properties

extension CarMakingViewController {

    private func setupProperties() {
        setupTitleBar()
        setupContentView()
        setupBottomModalView()
    }

    private func setupTitleBar() {
        let titleBarType: OhMyCarSetTitleBar.NavigationBarType = (mode == .selfMode) ? .selfMode : .guideMode
        titleBar = OhMyCarSetTitleBar(type: titleBarType)
        titleBar.delegate = self
        titleBar.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupContentView() {
        carMakingContentView = CarMakingContentView(frame: .zero, mode: mode)
        carMakingContentView.delegate = self
        carMakingContentView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupBottomModalView() {
        bottomModalView.delegate = self
        bottomModalView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - SetupViews

extension CarMakingViewController {

    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        [titleBar, carMakingContentView, bottomModalView].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        setupTitleBarConstraints()
        setupContentViewConstraints()
        setupBottomModalViewConstraints()
    }

    private func setupTitleBarConstraints() {
        NSLayoutConstraint.activate([
            titleBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleBar.heightAnchor.constraint(equalToConstant: Constants.titleBarHeight)
        ])
    }

    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            carMakingContentView.topAnchor.constraint(equalTo: titleBar.bottomAnchor),
            carMakingContentView.leadingAnchor.constraint(equalTo: titleBar.leadingAnchor),
            carMakingContentView.trailingAnchor.constraint(equalTo: titleBar.trailingAnchor),
            carMakingContentView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -Constants.bottomModalViewHeight
            )
        ])
    }

    private func setupBottomModalViewConstraints() {
        NSLayoutConstraint.activate([
            bottomModalView.leadingAnchor.constraint(equalTo: titleBar.leadingAnchor),
            bottomModalView.trailingAnchor.constraint(equalTo: titleBar.trailingAnchor),
            bottomModalView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
