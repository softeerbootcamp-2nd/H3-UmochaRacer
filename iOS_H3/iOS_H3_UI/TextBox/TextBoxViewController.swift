//
//  TextBoxViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/22.
//

import UIKit
import Combine

final class TextBoxViewController: UIViewController {

    // MARK: - UI properties
    private var textBoxView: TextBoxView!

    // MARK: - Properties
    private let viewModel: TextBoxViewModel
    private let tapOutsideBoxSubject = PassthroughSubject<Void, Never>()
    private let viewDidLoadSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let targetString: String
    var onDismiss: (() -> Void)?

    // MARK: - Lifecycles
    init(viewModel: TextBoxViewModel, targetString: String) {
        self.viewModel = viewModel
        self.targetString = targetString
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        let dictionaryRepository = DictionaryRepository(networkService: NetworkService())
        let usecase = DictionaryUsecase(dictionaryRepository: dictionaryRepository)
        self.viewModel = TextBoxViewModel(usecase: usecase)
        targetString = ""
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupTextBoxView()
        bind()
        viewDidLoadSubject.send(targetString)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?()
    }

    private func bind() {
        let input = TextBoxViewModel.Input(
            viewDidLoad: viewDidLoadSubject
        )

        let output = viewModel.transform(input: input)

        output.description
            .receive(on: DispatchQueue.main)
            .sink {[weak self] result in
                self?.textBoxView.updateText(result)
            }
            .store(in: &cancellables)
    }

    // MARK: - Helpers

    private func setupTextBoxView() {
        textBoxView = TextBoxView()
        textBoxView.setTitle("\(targetString)이 뭔가요?")
        view.addSubview(textBoxView)
        textBoxView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textBoxView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -168),
            textBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textBoxView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])

        textBoxView.delegate = self

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideTextBox(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapOutsideTextBox(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: textBoxView)
        if !textBoxView.bounds.contains(location) {
            dismiss(animated: false)
        }
    }
}

extension TextBoxViewController: TextBoxViewDelegate {
    func didTapUnderstoodButton(in view: TextBoxView) {
        self.dismiss(animated: false)
    }
}
