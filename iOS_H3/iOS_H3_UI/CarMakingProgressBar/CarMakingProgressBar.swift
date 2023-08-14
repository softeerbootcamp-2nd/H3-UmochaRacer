//
//  CarMakingProgressBar.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/06.
//

import UIKit

protocol CarMakingProgressBarDelegate: AnyObject {
    func progressBarButtonDidTapped(didSelectItemAt index: Int)
}

final class CarMakingProgressBar: UIScrollView {

    enum Constants {
        static let horizontalInset = 16.0
        static let barButtonSpacing = 24.0
    }

    // MARK: - UI properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let progressBarButtons = CarMakingStep.allCases.map {
        CarMakingProgressBarButton(title: $0.progressBarTitle)
    }

    // MARK: - Properties
    weak var progressBarDelegate: CarMakingProgressBarDelegate?

    private var selectedButtonIndex: Int = 0 {
        didSet {
            progressBarButtons[oldValue].isSelected = false
            progressBarButtons[selectedButtonIndex].isSelected = true
        }
    }

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

extension CarMakingProgressBar {

    private func setupViews() {
        self.showsHorizontalScrollIndicator = false

        setupProgressBarButtons()
        setupStackViewConstraints()
        addSubviewsOfStackView()
    }

    private func setupProgressBarButtons() {
        progressBarButtons.forEach { button in
            button.addTarget(self, action: #selector(progressBarButtonDidTapped(_:)), for: .touchUpInside)
        }
        progressBarButtons.first?.isSelected = true
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
        let spacingViews = (0...progressBarButtons.count).map { index in
            let spacingView = CarMakingProgressBarSpacingView()
            spacingView.translatesAutoresizingMaskIntoConstraints = false

            if index == 0 || index == progressBarButtons.count {
                spacingView.widthAnchor.constraint(equalToConstant: Constants.horizontalInset).isActive = true
            } else {
                spacingView.widthAnchor.constraint(equalToConstant: Constants.barButtonSpacing).isActive = true
            }

            return spacingView
        }

        for index in 0..<progressBarButtons.count {
            stackView.addArrangedSubview(spacingViews[index])
            stackView.addArrangedSubview(progressBarButtons[index])
        }
        stackView.addArrangedSubview(spacingViews[progressBarButtons.count])
    }

    @objc
    private func progressBarButtonDidTapped(_ sender: UIButton) {
        guard let index = progressBarButtons.firstIndex(where: { $0 == sender }) else {
            return
        }
        selectedButtonIndex = index
        moveContentOffset(to: index)
        progressBarDelegate?.progressBarButtonDidTapped(didSelectItemAt: index)
    }

    private func moveContentOffset(to index: Int) {
        let buttonWidth = progressBarButtons[index].bounds.width
        let inset = Constants.horizontalInset * (index == 0 ? 1 : 0.5)
        var offset = (buttonWidth + Constants.barButtonSpacing) * CGFloat(index)
        + inset - (bounds.width / 2) + (buttonWidth / 2)
        offset = min(offset, contentSize.width - bounds.width)
        setContentOffset(CGPoint(x: max(0, offset), y: 0), animated: true)
    }
}
