//
//  CarMakingOptionSelectStepCell.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/18.
//

import UIKit
import Combine

final class CarMakingOptionSelectStepCell: CarMakingCollectionViewCell {

    static let identifier = "CarMakingOptionSelectStepCell"

    enum Constants {
        static let prefixOfOptionCountLabel = "선택 옵션"
        static let selectedOptionCountLabelLeadingOffset = 12.0
        static let listModeButtonTrailingOffset = 16.0
        static let listModeWidth = 20.0
        static let listModeHeight = 20.0
        static let categoryTabBarTopOffset = 8.0
        static let categoryTabBarHeight = 32.0
    }

    // MARK: - UI properties

    private let selectedOptionCountLabel = UILabel()

    private let listModeButton = UIButton()

    private let listModeView = OptionListModeView(carMakingMode: .selfMode)

    private let categoryTabBar = OptionCategoryTabBar()

    // MARK: - Properties

    private var currentOptionInfo = [OptionCardInfo]()

    private var currentCategory = OptionCategoryType.system

    var optionCategoryTapSubject = PassthroughSubject<OptionCategoryType, Never>()

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame, buttonListViewable: MultiOptionCardButtonView.init())

        setupProperties()
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupProperties()
        setupViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        listModeView.isHidden = true
        currentOptionInfo = []
        currentCategory = OptionCategoryType.system
        optionCategoryTapSubject = PassthroughSubject<OptionCategoryType, Never>()
    }

    // MARK: - Helpers

    override func configure(optionInfoArray: [OptionCardInfo]) {
        super.configure(optionInfoArray: optionInfoArray)
        updateSelectedOptionCountLabel(optionInfoArray: optionInfoArray)
        listModeView.configure(with: optionInfoArray)
        currentOptionInfo = optionInfoArray
    }

    override func update(optionInfoArray: [OptionCardInfo]) {
        super.update(optionInfoArray: optionInfoArray)
        updateSelectedOptionCountLabel(optionInfoArray: optionInfoArray)
        listModeView.reloadOptionCards(with: optionInfoArray)
        currentOptionInfo = optionInfoArray
    }

    override func playFeedbackAnimation(title: String, description: String, completion: (() -> Void)? = nil) {
        super.playFeedbackAnimation(title: title, description: description, completion: completion)
        listModeView.playFeedbackAnimation(feedbackTitle: title, feedbackDescription: description)
    }

    private func updateSelectedOptionCountLabel(optionInfoArray: [OptionCardInfo]) {
        let selectedOptionCount = optionInfoArray.filter { $0.isSelected }.count
        selectedOptionCountLabel.text = "\(Constants.prefixOfOptionCountLabel) \(selectedOptionCount)"
    }

    private func showListModeView(isHidden: Bool) {
        if isHidden {
            super.configure(optionInfoArray: currentOptionInfo)
        }
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.listModeView.isHidden = isHidden
        })
    }
}

// MARK: - OptionListModeView Delegate

extension CarMakingOptionSelectStepCell: OptionListModeViewDelegate {
    func optionListModeViewDidTapImageModeButton(with optionListModeView: OptionListModeView) {
        showListModeView(isHidden: true)
    }
}

// MARK: - OptionCategoryTabBar Delegate

extension CarMakingOptionSelectStepCell: OptionCategoryTabBarDelegate {
    func tabBarButtonDidTapped(didSelectItemAt index: Int) {
        guard let category = OptionCategoryType(rawValue: index) else {
            return
        }

        if currentCategory != category {
            currentCategory = category
            optionCategoryTapSubject.send(category)
        }
    }
}

// MARK: - Setup

extension CarMakingOptionSelectStepCell {

    private func setupProperties() {
        setupSelectedOptionCountLabel()
        setupListModeButton()
        setupListModeView()
        setupCategoryTabBar()
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
    }

    private func setupSelectedOptionCountLabel() {
        selectedOptionCountLabel.text = "\(Constants.prefixOfOptionCountLabel) 0"
        selectedOptionCountLabel.font = Fonts.regularBody3
        selectedOptionCountLabel.textColor = Colors.subActiveBlue
        selectedOptionCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupListModeButton() {
        listModeButton.setImage(UIImage(named: "list_mode_button"), for: .normal)
        listModeButton.tintColor = .black
        listModeButton.addTarget(self, action: #selector(listModeButtonDidTap), for: .touchUpInside)
        listModeButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupListModeView() {
        listModeView.translatesAutoresizingMaskIntoConstraints = false
        listModeView.isHidden = true
        listModeView.backgroundColor = .white
        listModeView.delegate = self
        listModeView.listModeViewDelegate = self
    }

    private func setupCategoryTabBar() {
        categoryTabBar.translatesAutoresizingMaskIntoConstraints = false
        categoryTabBar.tabBarDelegate = self
    }

    @objc
    private func listModeButtonDidTap() {
        showListModeView(isHidden: false)
    }

    private func addSubviews() {
        [selectedOptionCountLabel, listModeButton, listModeView, categoryTabBar]
            .forEach {
                contentView.addSubview($0)
            }
    }

    private func setupConstraints() {
        setupSelectedOptionCountLabelConstraints()
        setupListModeButtonConstraints()
        setupListModeViewConstraints()
        setupCategoryTabBarConstraints()
    }

    private func setupSelectedOptionCountLabelConstraints() {
        NSLayoutConstraint.activate([
            selectedOptionCountLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            selectedOptionCountLabel.leadingAnchor.constraint(
                equalTo: descriptionLabel.trailingAnchor,
                constant: Constants.selectedOptionCountLabelLeadingOffset
            )
        ])
    }

    private func setupListModeButtonConstraints() {
        NSLayoutConstraint.activate([
            listModeButton.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
            listModeButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.listModeButtonTrailingOffset
            ),
            listModeButton.widthAnchor.constraint(equalToConstant: Constants.listModeWidth),
            listModeButton.heightAnchor.constraint(equalToConstant: Constants.listModeHeight)
        ])
    }

    private func setupListModeViewConstraints() {
        NSLayoutConstraint.activate([
            listModeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listModeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listModeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listModeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupCategoryTabBarConstraints() {
        NSLayoutConstraint.activate([
            categoryTabBar.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.categoryTabBarTopOffset
            ),
            categoryTabBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryTabBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryTabBar.heightAnchor.constraint(equalToConstant: Constants.categoryTabBarHeight)
        ])
    }
}
