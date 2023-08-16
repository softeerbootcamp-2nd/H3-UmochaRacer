//
//  OptionListModeViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/16.
//

import UIKit

final class OptionListModeViewController: UIViewController {

    // MARK: - UI properties

    private lazy var selfModeOptionModeListView: OptionListModeView = {
        let view = OptionListModeView(carMakingMode: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties
    var cardInfos: [OptionCardInfo] = [
        .init(title: "20인치 알로이 휠 & 타이어", subTitle: "구매자의 95%가 선택한", priceString: "+ 0원"),
            .init(title: "20인치 블랙톤 전면 가공 휠", subTitle: "구매자의 2%가 선택한", priceString: "+ 0원"),
            .init(title: "가죽 시트", subTitle: "구매자의 60%가 선택한", priceString: "+ 200,000원"),
            .init(title: "선루프", subTitle: "구매자의 30%가 선택한", priceString: "+ 500,000원"),
            .init(title: "하이 엔드 오디오 시스템", subTitle: "구매자의 10%가 선택한", priceString: "+ 300,000원"),
            .init(title: "내비게이션 시스템", subTitle: "구매자의 75%가 선택한", priceString: "+ 100,000원"),
            .init(title: "후방 카메라", subTitle: "구매자의 50%가 선택한", priceString: "+ 150,000원"),
            .init(title: "히터 내장 사이드 미러", subTitle: "구매자의 20%가 선택한", priceString: "+ 50,000원"),
            .init(title: "자동 에어컨", subTitle: "구매자의 40%가 선택한", priceString: "+ 250,000원"),
            .init(title: "헤드 업 디스플레이", subTitle: "구매자의 15%가 선택한", priceString: "+ 400,000원"),
            .init(title: "무선 충전 패드", subTitle: "구매자의 25%가 선택한", priceString: "+ 80,000원")
    ]

    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegate()
        setupViews()
        self.selfModeOptionModeListView.updateAllViews(with: cardInfos)
    }

    // MARK: - Helpers

    private func setupDelegate() {
        selfModeOptionModeListView.delegate = self
    }

    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(selfModeOptionModeListView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selfModeOptionModeListView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            selfModeOptionModeListView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            selfModeOptionModeListView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            selfModeOptionModeListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}

extension OptionListModeViewController: OptionListModeViewDelegate {
    func optionListModeView(with: OptionListModeView, didSelectedIndex: Int) {
        cardInfos[didSelectedIndex].isSelected.toggle()
        selfModeOptionModeListView.updateAllViews(with: cardInfos)
    }

    func optionListModeViewDidTapImageModeButton(with: OptionListModeView) {
        self.dismiss(animated: true)
    }
}
