//
//  ImageDetailPopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import UIKit
import Combine

class ImageDetailPopupViewController: UIViewController {

    // MARK: - UI properties
    @IBOutlet weak var optionImageView: UIImageView!
    
    @IBOutlet weak var optionImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var additionalInfoContainerView: UIView!

    @IBOutlet weak var descriptionTextView: URLabel!
    
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var pageControlContainerView: UIView!
    private let pagingControlView = PagingControlView(frame: .zero)

    // MARK: - Properties
    private var viewModel: DetailPopupViewModel!
    private var cancellables = Set<AnyCancellable>()
    private let viewDidLoadSubject = PassthroughSubject<Int, Never>()
    private let pageDidChangeSubject = CurrentValueSubject<Int, Never>(0)
    private let selectedURStringRangeSubject = PassthroughSubject<NSRange, Never>()
    private var info: OptionCardInfo?
    private var step: CarMakingStep?
    private let textEffectManager = TextEffectManager.shared
    // MARK: - Lifecycles
    init(viewModel: DetailPopupViewModel, info: OptionCardInfo, carMakingStep : CarMakingStep) {
        self.viewModel = viewModel
        self.info = info
        self.step = carMakingStep
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = DetailPopupViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
        if let info = info {
            viewDidLoadSubject.send(info.id)
        }
        descriptionTextView.delegate = self
    }

    // MARK: - Helpers

    @IBAction func didTapExitButton(_ sender: UIButton) {
        self.dismiss(animated: false)
    }

    private func bind() {
        let input = DetailPopupViewModel.Input(
            viewDidLoad: viewDidLoadSubject,
            pageDidChange: pageDidChangeSubject,
            selectedURStringRange: selectedURStringRangeSubject,
            isImageDetail: true,
            id: info?.id ?? 1,
            step: step ?? .powertrain
        )
        let output = viewModel.transform(input)

        output.title
            .map { $0 }
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)

        output.subTitle
            .map { $0 }
            .assign(to: \.text, on: subTitleLabel)
            .store(in: &cancellables)

        output.description
            .sink { [weak self] result in
                self?.updateDescriptionView(with: result)
            }
            .store(in: &cancellables)

        output.additionalInfo
            .sink { [weak self] info in
                if info.isEmpty {
                    self?.additionalInfoContainerView.isHidden = true
                } else {
                    self?.additionalInfoContainerView.isHidden = false
                    self?.updateAdditionalInfoViews(with: info)
                    if let infoView = self?.additionalInfoContainerView {
                        self?.applyDictionaryEffectIfNeeded(view: infoView)
                    }

                    print("결과 \(info)")
                }
            }.store(in: &cancellables)

        output.pageCount
            .sink { [weak self] pageCount in
                self?.configurePagingControlView(pageCount: pageCount)
            }
            .store(in: &cancellables)

        output.imageURL
            .sink { [weak self] imageURL in
                guard let self = self else { return }
                if let url = URL(string: imageURL ?? ""), UIImage(contentsOfFile: url.path) != nil {
                    self.optionImageView.loadCachedImage(of: url)
                    self.animateImageViewHeight(to: 179)
                    self.exitButton.tintColor = Colors.coolGrey3
                } else {
                    self.optionImageView.image = nil
                    self.animateImageViewHeight(to: 0)
                }
            }
            .store(in: &cancellables)

        output.selectedURStringRange
            .sink { [weak self] range in
                self?.descriptionTextView.selectedRange = range
            }
            .store(in: &cancellables)
    }

    private func animateImageViewHeight(to height: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }

            self.optionImageViewHeightConstraint.constant = height
            self.view.layoutIfNeeded()
        }
    }

    private func updateDescriptionView(with result: URString) {
        descriptionTextView.setURString(result, isOn: false)
        descriptionTextView.text = result.fullText

        applyDictionaryEffectIfNeeded(view: descriptionTextView)
    }

    private func applyDictionaryEffectIfNeeded(view: UIView) {
        guard textEffectManager.isDictionaryFunctionActive else { return }
        textEffectManager.applyEffect(true, on: view)
    }
}

extension ImageDetailPopupViewController {
    private func setupViews() {
        setupFonts()
        setupColors()
        setupPagingControlView()
    }

    private func setupFonts() {
        self.subTitleLabel.font = Fonts.regularTitle6
        self.titleLabel.font = Fonts.mediumTitle4
        self.descriptionTextView.font = Fonts.regularBody2
//
    }

    private func setupColors() {
        additionalInfoContainerView.backgroundColor = Colors.coolGrey1
        self.subTitleLabel.textColor = Colors.coolGrey3
//
    }

    private func setupPagingControlView() {
        addPagingControlView()
        setupPagingControlViewConstraints()
    }

    private func addPagingControlView() {
        pageControlContainerView.addSubview(pagingControlView)
        pagingControlView.delegate = self
        pagingControlView.setCurrentPage(0)
    }

    private func configurePagingControlView(pageCount: Int) {
        if pageCount <= 1 {
            pagingControlView.isHidden = true
        }
        pagingControlView.setNumberOfPages(pageCount)
    }

    private func setupPagingControlViewConstraints() {
        pagingControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingControlView.topAnchor.constraint(equalTo: pageControlContainerView.topAnchor),
            pagingControlView.bottomAnchor.constraint(equalTo: pageControlContainerView.bottomAnchor),
            pagingControlView.leadingAnchor.constraint(equalTo: pageControlContainerView.leadingAnchor),
            pagingControlView.trailingAnchor.constraint(equalTo: pageControlContainerView.trailingAnchor)
        ])
    }

    private func updateAdditionalInfoViews(with infos: [URString]) {
        for view in infoStackView.arrangedSubviews {
            infoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        for info in infos {
            let view = UIView()
            let titleLabel = URLabel()
            let descriptionLabel = URLabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

            titleLabel.font = Fonts.regularBody2
            titleLabel.textColor = Colors.coolGrey4
            descriptionLabel.font = Fonts.regularBody2
            descriptionLabel.textColor = Colors.coolGrey4

            view.addSubview(titleLabel)
            view.addSubview(descriptionLabel)
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])

            NSLayoutConstraint.activate([
                descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
                descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
            let fullTextArr = info.fullText.split(separator: ",")
                .map { String($0) }
            
            if let first = fullTextArr.first, let last = fullTextArr.last {
                let titleText = first.toURString()
                let descriptionText = last.toURString()
                titleLabel.setURString(titleText, isOn: false)
                descriptionLabel.setURString(descriptionText, isOn: false)
                titleLabel.text = titleText.fullText
                descriptionLabel.text = descriptionText.fullText
            }
            infoStackView.addArrangedSubview(view)
        }
    }
}

extension ImageDetailPopupViewController: PagingControlViewDelegate {
    func didTapPreviousButton() {
        let previousPage = max(pageDidChangeSubject.value - 1, 0)
        pageDidChangeSubject.send(previousPage)
    }

    func didTapNextButton() {
        let nextPage = min(pageDidChangeSubject.value + 1, pagingControlView.numberOfPages - 1)
        pageDidChangeSubject.send(nextPage)
    }
}

extension ImageDetailPopupViewController: URLabelDelegate {
    func label(_ label: URLabel, didSelectRange range: NSRange?) {
        guard let range = range else { return }
        selectedURStringRangeSubject.send(range)
    }
}
