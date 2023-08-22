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
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var additionalInfoContainerView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var infoContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControlContainerView: UIView!
    private let pagingControlView = PagingControlView(frame: .zero)

    // MARK: - Properties
    private var viewModel: DetailPopupViewModel!
    private var cancellables = Set<AnyCancellable>()
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let pageDidChangeSubject = CurrentValueSubject<Int, Never>(0)

    // MARK: - Lifecycles
    init(viewModel: DetailPopupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = DetailPopupViewModel()
        super.init(coder: coder)
    }

    // MARK: - Helpers
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()

    }

    // MARK: - Helpers

    @IBAction func didTapExitButton(_ sender: UIButton) {
        self.dismiss(animated: false)
    }

    private func bind() {
        let input = DetailPopupViewModel.Input(
            viewDidLoad: viewDidLoadSubject,
            pageDidChange: pageDidChangeSubject,
            isImageDetail: true
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
            .assign(to: \.text, on: descriptionTextView)
            .store(in: &cancellables)

        output.additionalInfo
            .map { $0 }
            .assign(to: \.text, on: additionalInfoLabel)
            .store(in: &cancellables)

        output.pageCount
            .sink { [weak self] pageCount in
                print("pageCount : \(pageCount)")
                self?.configurePagingControlView(pageCount: pageCount)
            }
            .store(in: &cancellables)

        output.imageURL
            .sink { [weak self] imageURL in
                if let url = imageURL {
                    self?.optionImageView.loadCachedImage(of: url)
                }
            }
            .store(in: &cancellables)
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
        additionalInfoLabel.font = Fonts.regularBody2
    }

    private func setupColors() {
        additionalInfoContainerView.backgroundColor = Colors.coolGrey1
        self.subTitleLabel.textColor = Colors.coolGrey3
        additionalInfoLabel.textColor = Colors.coolGrey4
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
}

extension ImageDetailPopupViewController: PagingControlViewDelegate {
    func didTapPreviousButton() {
        let previousPage = max(pageDidChangeSubject.value - 1, 0)
        pageDidChangeSubject.send(previousPage)
    }

    func didTapNextButton() {
        let nextPage = min(pagingControlView.currentPage + 1, pagingControlView.numberOfPages - 1)
        pageDidChangeSubject.send(nextPage)
    }
}
