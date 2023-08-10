//
//  MultiOptionCardButtonViewController.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit

final class MultiOptionCardButtonViewController: UIViewController {
    
    enum Constants {
        static let inset = 16.0
        static let cardButtonViewHeight = 168.0
    }

    // MARK: - UI properties

    private lazy var selfModeMultiOptionCardButtonView: MultiOptionCardButtonView = {
        let view = MultiOptionCardButtonView(type: .selfMode)
        view.updateAllViews(with: self.cardInfos)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let guideModeMultiOptionCardButtonView: MultiOptionCardButtonView = {
        let view = MultiOptionCardButtonView(type: .guideMode)

        let cardInfos: [OptionCardInfo] = [
            .init(title: "20인치 알로이 휠 & 타이어", subTitle: "구매자의 95%가 선택한", priceString: "+ 0원"),
            .init(title: "20인치 블랙톤 전면 가공 휠", subTitle: "구매자의 2%가 선택한", priceString: "+ 0원")
        ]
        view.updateAllViews(with: cardInfos)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    var cardInfos: [OptionCardInfo] = [
        .init(title: "20인치 알로이 휠 & 타이어", subTitle: "구매자의 95%가 선택한", priceString: "+ 0원"),
        .init(title: "20인치 블랙톤 전면 가공 휠", subTitle: "구매자의 2%가 선택한", priceString: "+ 0원"),
        .init(title: "셀3", subTitle: "구매자의 95%가 선택한", priceString: "+ 0원"),
        .init(title: "셀4", subTitle: "구매자의 2%가 선택한", priceString: "+ 0원")
    ]

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupViews()
    }

    // MARK: - Helpers
    
    private func setupDelegate() {
        selfModeMultiOptionCardButtonView.delegate = self
    }

    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(selfModeMultiOptionCardButtonView)
        view.addSubview(guideModeMultiOptionCardButtonView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selfModeMultiOptionCardButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            selfModeMultiOptionCardButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset),
            selfModeMultiOptionCardButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset),
            selfModeMultiOptionCardButtonView.heightAnchor.constraint(equalToConstant: Constants.cardButtonViewHeight)
        ])
        NSLayoutConstraint.activate([
            guideModeMultiOptionCardButtonView.topAnchor.constraint(equalTo: selfModeMultiOptionCardButtonView.bottomAnchor, constant: 10),
            guideModeMultiOptionCardButtonView.leadingAnchor.constraint(equalTo: selfModeMultiOptionCardButtonView.leadingAnchor),
            guideModeMultiOptionCardButtonView.trailingAnchor.constraint(equalTo: selfModeMultiOptionCardButtonView.trailingAnchor),
            guideModeMultiOptionCardButtonView.heightAnchor.constraint(equalTo: selfModeMultiOptionCardButtonView.heightAnchor)
        ])
    }
}

extension MultiOptionCardButtonViewController: MultiOptionCardButtonViewDelegate {
    func optionCardButtonDidTapped(index: Int) {
        cardInfos[index].isSelected.toggle()
        selfModeMultiOptionCardButtonView.updateAllViews(with: cardInfos)
    }
}