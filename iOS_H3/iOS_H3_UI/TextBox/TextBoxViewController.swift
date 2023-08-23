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
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var dictionaryTitle: String = ""
    var onDismiss: (() -> Void)?

    // MARK: - Lifecycles
    init(viewModel: TextBoxViewModel) {
        self.viewModel = TextBoxViewModel()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = TextBoxViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupTextBoxView()
        bind()
        viewDidLoadSubject.send()
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
            .sink {[weak self] result in
                self?.textBoxView.updateText(result)
                self?.textBoxView.setTitle(self?.dictionaryTitle ?? "")
            }
            .store(in: &cancellables)
    }

    // MARK: - Helpers
    func setTitle(title: String) {
        self.dictionaryTitle = "\(title)이 뭔가요?"
    }

    private func setupTextBoxView() {
        textBoxView = TextBoxView()
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
