//
//  OptionCategoryTabBar.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/13.
//

import UIKit

protocol OptionCategoryTabBarDelegate: AnyObject {
    func tabBarButtonDidTapped(didSelectItemAt index: Int)
}

final class OptionCategoryTabBar: UIScrollView {

    enum Constants {
        static let horizontalInset = 16.0
        static let buttonHorizontalPadding = 20.0
        static let buttonVerticalPadding = 6.0
    }

    // MARK: - UI properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: Constants.horizontalInset, bottom: 0, right: 0)
        return stackView
    }()

    private let progressBarButtons = OptionCategoryType.allCases.map {
        let button = OhMyCarSetButton(colorType: .coolGrey1, title: $0.title)
        button.changeColor(titleColor: Colors.coolGrey3, backgroundColor: Colors.coolGrey1)
        return button
    }

    // MARK: - Properties

    weak var tabBarDelegate: OptionCategoryTabBarDelegate?

    private var selectedButtonIndex: Int = 0 {
        didSet {
            progressBarButtons[oldValue].isSelected = false
            progressBarButtons[oldValue].changeColor(titleColor: Colors.coolGrey3,
                                                     backgroundColor: Colors.coolGrey1)
            progressBarButtons[selectedButtonIndex].isSelected = true
            progressBarButtons[selectedButtonIndex].changeColor(titleColor: .white,
                                                                backgroundColor: Colors.mainHyundaiBlue)
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

extension OptionCategoryTabBar {

    private func setupViews() {
        self.showsHorizontalScrollIndicator = false

        setupCategoryTabBarButtons()
        setupStackViewConstraints()
        addSubviewsOfStackView()
    }

    private func setupCategoryTabBarButtons() {
        progressBarButtons.forEach { button in
            setupButton(button)
        }
        progressBarButtons.first?.isSelected = true
        progressBarButtons.first?.changeColor(titleColor: .white, backgroundColor: Colors.mainHyundaiBlue)
    }

    private func setupButton(_ button: OhMyCarSetButton) {
        button.addTarget(self, action: #selector(progressBarButtonDidTapped(_:)), for: .touchUpInside)

        let textSize = button.titleLabel?.intrinsicContentSize ?? CGSize.zero
        let buttonWidth = textSize.width + 2 * Constants.buttonHorizontalPadding
        button.frame.size.width = buttonWidth
        button.contentEdgeInsets = UIEdgeInsets(top: Constants.buttonVerticalPadding,
                                                left: Constants.buttonHorizontalPadding,
                                                bottom: Constants.buttonVerticalPadding,
                                                right: Constants.buttonHorizontalPadding)
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
        progressBarButtons.forEach {
            stackView.addArrangedSubview($0)
        }
    }

    @objc
    private func progressBarButtonDidTapped(_ sender: UIButton) {
        guard let index = progressBarButtons.firstIndex(where: { $0 == sender }) else {
            return
        }
        selectedButtonIndex = index
        tabBarDelegate?.tabBarButtonDidTapped(didSelectItemAt: index)
    }
}
