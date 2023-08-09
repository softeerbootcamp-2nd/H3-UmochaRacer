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
        let view = TwoOptionCardButtonView(type: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let guideModeTwoOptionCardButtonView: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(type: .guideMode)
        view.updateView(index: 0, with: OptionCardInfo(title: "가솔린 3.8", subTitle: "구매자의 37%가 선택한", priceString: "+ 0원", isSelected: true))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let twoOptionCardButtonViewWithData: TwoOptionCardButtonView = {
        let view = TwoOptionCardButtonView(type: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        let cardInfos: [OptionCardInfo] = [
            .init(title: "디젤 2.2", subTitle: "구매자의 63%가 선택한", priceString: "+ 1,480,000원"),
            .init(title: "가솔린 3.8", subTitle: "구매자의 37%가 선택한", priceString: "+ 0원", isSelected: true)
        ]
        view.updateAllViews(with: cardInfos)
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
    }

    private func setupConstraints() {
        setupSelfModeTwoOptionCardButtonViewConstraints()
        setupGuideModeTwoOptionCardButtonViewConstraints()
        setupTwoOptionCardButtonViewWithDataConstraints()
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
}
