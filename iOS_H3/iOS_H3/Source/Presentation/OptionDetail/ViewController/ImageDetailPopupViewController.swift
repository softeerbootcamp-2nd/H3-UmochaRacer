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
    init(viewModel: DetailPopupViewModel, info: OptionCardInfo, carMakingStep: CarMakingStep) {
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
        bindOutput(output)
    }

    private func bindOutput(_ output: DetailPopupViewModel.Output) {
           bindLabel(output.title, to: titleLabel)
           bindLabel(output.subTitle, to: subTitleLabel)
           bindTextView(output.description, to: descriptionTextView)

           output.additionalInfo
               .receive(on: DispatchQueue.main)
               .sink { [weak self] info in
                   self?.handleAdditionalInfo(info)
               }
               .store(in: &cancellables)

           output.pageCount
               .receive(on: DispatchQueue.main)
               .sink { [weak self] pageCount in
                   self?.configurePagingControlView(pageCount: pageCount)
               }
               .store(in: &cancellables)

           output.imageURL
               .receive(on: DispatchQueue.main)
               .sink { [weak self] imageURL in
                   self?.handleImageURL(imageURL)
               }
               .store(in: &cancellables)
       }

       private func handleAdditionalInfo(_ info: [URString]) {
           if info.isEmpty {
               additionalInfoContainerView.isHidden = true
           } else {
               additionalInfoContainerView.isHidden = false
               updateAdditionalInfoViews(with: info)
               applyDictionaryEffectIfNeeded(view: additionalInfoContainerView)
           }
       }

       private func handleImageURL(_ imageURL: String?) {
           if let url = URL(string: imageURL ?? "") {
               optionImageView.loadCachedImage(of: url)
               animateImageViewHeight(to: 179)
               exitButton.tintColor = Colors.coolGrey3
           } else {
               optionImageView.image = nil
               animateImageViewHeight(to: 0)
           }
       }

       private func bindLabel(_ subject: CurrentValueSubject<String, Never>, to label: UILabel) {
           subject
               .receive(on: DispatchQueue.main)
               .sink { [weak self] text in
                   self?.updateLabel(label, with: URString(fullText: text))
               }
               .store(in: &cancellables)
       }

    private func bindTextView(_ subject: CurrentValueSubject<URString, Never>, to textView: URLabel) {
        subject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.updateLabel(textView, with: text)
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

    private func updateLabel(_ view: UIView, with result: URString) {
        switch view {
        case let label as UILabel:
            label.text = result.fullText

        case let textView as URLabel:
            textView.setURString(result, isOn: false)
            textView.text = result.fullText
            applyDictionaryEffectIfNeeded(view: textView)

        default:
            break
        }
    }

    private func applyDictionaryEffectIfNeeded(view: UIView) {
        guard textEffectManager.isDictionaryFunctionActive else { return }
        textEffectManager.applyEffect(true, on: view)
    }
}

extension ImageDetailPopupViewController {
    private func setupViews() {
        titleLabel.numberOfLines = 0
        setupFonts()
        setupColors()
        setupPagingControlView()
    }

    private func setupFonts() {
        self.subTitleLabel.font = Fonts.regularTitle6
        self.titleLabel.font = Fonts.mediumTitle4
        self.descriptionTextView.font = Fonts.regularBody2
    }

    private func setupColors() {
        additionalInfoContainerView.backgroundColor = Colors.coolGrey1
        self.subTitleLabel.textColor = Colors.coolGrey3
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
        } else {
            pagingControlView.isHidden = false
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
        clearPreviousInfoViews()

        infos.forEach { info in
            let (titleLabel, descriptionLabel) = createTitleAndDescriptionLabels(from: info)
            let containerView = setupContainerView(with: titleLabel, and: descriptionLabel)
            infoStackView.addArrangedSubview(containerView)
        }
    }

    private func clearPreviousInfoViews() {
        infoStackView.arrangedSubviews.forEach { view in
            infoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    private func createTitleAndDescriptionLabels(from info: URString) -> (URLabel, URLabel) {
        let titleLabel = setupLabel()
        let descriptionLabel = setupLabel()

        let fullTextArr = info.fullText.split(separator: ",").map(String.init)
        if let first = fullTextArr.first, let last = fullTextArr.last {
            setTitleAndDescription(for: titleLabel,
                                   titleText: first.toURString(),
                                   and: descriptionLabel,
                                   descriptionText: last.toURString())
        }

        return (titleLabel, descriptionLabel)
    }

    private func setupLabel() -> URLabel {
        let label = URLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regularBody2
        label.textColor = Colors.coolGrey4
        return label
    }

    private func setTitleAndDescription(for titleLabel: URLabel,
                                        titleText: URString,
                                        and descriptionLabel: URLabel,
                                        descriptionText: URString) {
        titleLabel.setURString(titleText, isOn: false)
        descriptionLabel.setURString(descriptionText, isOn: false)
        titleLabel.text = titleText.fullText
        descriptionLabel.text = descriptionText.fullText
    }

    private func setupContainerView(with titleLabel: URLabel, and descriptionLabel: URLabel) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])

        return containerView
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
