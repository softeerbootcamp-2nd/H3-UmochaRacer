//
//  TwoOptionCardButtonViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/07.
//

import UIKit

final class TwoOptionCardButtonViewController: UIViewController {

    // MARK: - UI properties

    private let selfModeTwoOptionCardButtonView: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(carMakingMode: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let guideModeTwoOptionCardButtonView: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(carMakingMode: .guideMode)
        view.updateOptionCard(
            at: 0,
            with: CarMakingContentMockData.mockOption[0][0]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let twoOptionCardButtonViewWithData: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(carMakingMode: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: CarMakingContentMockData.mockOption[0])
        return view
    }()

    private let moreInfoVersionView: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(carMakingMode: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: CarMakingContentMockData.mockOption[0])
        return view
    }()

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // MARK: - Helpers

    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(selfModeTwoOptionCardButtonView)
        view.addSubview(guideModeTwoOptionCardButtonView)
        view.addSubview(twoOptionCardButtonViewWithData)
        view.addSubview(moreInfoVersionView)
    }

    private func setupConstraints() {
        setupSelfModeTwoOptionCardButtonViewConstraints()
        setupGuideModeTwoOptionCardButtonViewConstraints()
        setupTwoOptionCardButtonViewWithDataConstraints()
        setupMoreInfoVersionViewConstraints()
    }

    private func setupSelfModeTwoOptionCardButtonViewConstraints() {
        NSLayoutConstraint.activate([
            selfModeTwoOptionCardButtonView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            selfModeTwoOptionCardButtonView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            selfModeTwoOptionCardButtonView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            selfModeTwoOptionCardButtonView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func setupGuideModeTwoOptionCardButtonViewConstraints() {
        NSLayoutConstraint.activate([
            guideModeTwoOptionCardButtonView.topAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.bottomAnchor,
                constant: 10
            ),
            guideModeTwoOptionCardButtonView.leadingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.leadingAnchor
            ),
            guideModeTwoOptionCardButtonView.trailingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.trailingAnchor
            ),
            guideModeTwoOptionCardButtonView.heightAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.heightAnchor
            )
        ])
    }

    private func setupTwoOptionCardButtonViewWithDataConstraints() {
        NSLayoutConstraint.activate([
            twoOptionCardButtonViewWithData.topAnchor.constraint(
                equalTo: guideModeTwoOptionCardButtonView.bottomAnchor,
                constant: 10
            ),
            twoOptionCardButtonViewWithData.leadingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.leadingAnchor
            ),
            twoOptionCardButtonViewWithData.trailingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.trailingAnchor
            ),
            twoOptionCardButtonViewWithData.heightAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.heightAnchor
            )
        ])
    }

    private func setupMoreInfoVersionViewConstraints() {
        NSLayoutConstraint.activate([
            moreInfoVersionView.topAnchor.constraint(
                equalTo: twoOptionCardButtonViewWithData.bottomAnchor,
                constant: 10
            ),
            moreInfoVersionView.leadingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.leadingAnchor
            ),
            moreInfoVersionView.trailingAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.trailingAnchor
            ),
            moreInfoVersionView.heightAnchor.constraint(
                equalTo: selfModeTwoOptionCardButtonView.heightAnchor
            )
        ])
    }
}
