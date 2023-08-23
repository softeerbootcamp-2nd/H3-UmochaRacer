//
//  TrimListBar.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/23.
//

import UIKit

final class TrimListBar: UIScrollView {

    enum Constants {
        static let barButtonSpacing = 12.0
        static let barButtonWidth = 200.0
        static let sideSpacingViewWitdh = 4.0
    }

    // MARK: - UI properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.barButtonSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let trimListBarButtons = TrimCategory.allCases.map {
        TrimListBarButton(frame: .zero, category: $0)
    }

    // MARK: - Properties

    private var selectedButtonIndex: Int = 0

    // MARK: - Lifecycles

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Helpers
}

extension TrimListBar {

    private func setupViews() {
        self.showsHorizontalScrollIndicator = false
        setupTrimListBarButtons()
        setupStackViewConstraints()
        addSubviewsOfStackView()
    }

    private func setupTrimListBarButtons() {
        trimListBarButtons.forEach { button in
            button.addTarget(self, action: #selector(trimListBarButtonDidTapped(_:)), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: Constants.barButtonWidth).isActive = true
        }
        trimListBarButtons.first?.isSelected = true
    }

    private func setupStackViewConstraints() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }

    private func addSubviewsOfStackView() {
        stackView.addArrangedSubview(createSideSpacingView())
        trimListBarButtons.forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.addArrangedSubview(createSideSpacingView())
    }

    @objc
    private func trimListBarButtonDidTapped(_ sender: UIButton) {
        guard let index = trimListBarButtons.firstIndex(where: { $0 == sender }) else {
            return
        }
        let previousSelectedIndex = selectedButtonIndex
        selectedButtonIndex = index

        trimListBarButtons[previousSelectedIndex].isSelected = false
        trimListBarButtons[selectedButtonIndex].isSelected = true
    }

    private func createSideSpacingView() -> UIView {
        let spacingView = UIView()
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.widthAnchor.constraint(equalToConstant: Constants.sideSpacingViewWitdh).isActive = true
        return spacingView
    }
}
