//
//  CarMakingProgressBar.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import UIKit

final class CarMakingProgressBar: UIScrollView {

    // MARK: - UI properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

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

    private func setupViews() {
        self.showsHorizontalScrollIndicator = false

        setupStackViewConstraints()
        addSubviewsOfStackView()
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
        let progressBarButtons = CarMakingStep.allCases.map {
            CarMakingProgressBarButton(title: $0.progressBarTitle)
        }
        progressBarButtons.first?.isSelected = true

        let spacingViews = (0...progressBarButtons.count).map { index in
            let spacingView = CarMakingProgressBarSpacingView()
            spacingView.translatesAutoresizingMaskIntoConstraints = false

            let width = index == 0 || index == progressBarButtons.count ? 16.0 : 24.0
            spacingView.widthAnchor.constraint(equalToConstant: width).isActive = true

            return spacingView
        }

        for index in 0..<progressBarButtons.count {
            stackView.addArrangedSubview(spacingViews[index])
            stackView.addArrangedSubview(progressBarButtons[index])
        }
        stackView.addArrangedSubview(spacingViews[progressBarButtons.count])
    }
}
