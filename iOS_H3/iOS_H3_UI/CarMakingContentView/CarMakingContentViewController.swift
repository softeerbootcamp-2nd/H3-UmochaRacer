//
//  CarMakingContentViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/10.
//

import UIKit

final class CarMakingContentViewController: UIViewController {

    enum Constants {
        static let inset: CGFloat = 0.0
    }

    // MARK: - UI Properties
    lazy var selfModeBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .selfMode)
        titleBar.delegate = self
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        return titleBar
    }()

    private lazy var carMakingContentView: CarMakingContentView = {
        let view = CarMakingContentView<PageSection>(frame: .zero, mode: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        carMakingContentView.dataSource = self
    }

    // MARK: - Helpers
    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        self.view.addSubview(selfModeBar)
        self.view.addSubview(carMakingContentView)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            selfModeBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            selfModeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            selfModeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            selfModeBar.heightAnchor.constraint(equalToConstant: 50),

            carMakingContentView.topAnchor.constraint(equalTo: selfModeBar.bottomAnchor, constant: 0),
            carMakingContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset),
            carMakingContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset),
            carMakingContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
}
extension CarMakingContentViewController: OhMyCarSetTitleBarDelegate {
    func titleButtonTapped() {
        print("titleButton Pressed")
    }

    func backButtonPressed() {
        print("backButton Pressed")
        self.dismiss(animated: true)
    }

    func skipButtonPressed() {
        print("skipButton Pressed")
    }

    func dictionaryButtonPressed() {
        print("dictionaryButton Pressed")
    }

    func changeModelButtonPressed() {
        print("changeModelButton Pressed")
    }
}

extension CarMakingContentViewController: CarMakingContentViewDataSource {

    func numberOfSections() -> Int {
        return PageSection.allCases.count
    }

    func contentView(numberOfItemsInSection section: Int) -> Int {
        return CarMakingStep.allCases.count
    }

    func contentView(stepAtIndexPath indexPath: IndexPath) -> CarMakingStep {
        return CarMakingStep.allCases[indexPath.row]
    }

    func contentView(urlForItemAtIndex indexPath: IndexPath) -> String? {
        return CarMakingContentMockData.mockURL[indexPath.section][indexPath.row]
    }

    func contentView(optionsForItemAtIndex indexPath: IndexPath) -> [OptionCardInfo]? {
        return CarMakingContentMockData.mockOption[indexPath.section][indexPath.row]
    }
}

// Mock Data
struct CarMakingContentMockData {
    static let mockURL = [
        ["https://cdn.autotribune.co.kr/news/photo/202101/4849_30727_3533.jpg",
         // swiftlint:disable:next line_length
         "https://i.namu.wiki/i/cBMX6XiTLltPPIawbb2zfP5Oy5RW9JybY0E5ZQ62oUYdppA2t54xDjiST7xfLe_2dL4pGN9VsBVknq4H-SYA2A.webp",
         "https://cdn.epnc.co.kr/news/photo/201804/79474_70575_4841.jpg",
         "https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089982_79.jpg"],
        ["https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089971_11.jpg",
         "https://itimg.chosun.com/sitedata/image/202112/03/2021120301496_0.jpg",
         "https://www.hyundai-wia.com/img/business/auto_engine_detail_img_5.jpg",
         "https://www.hyundai-wia.com/img/business/auto_engine_detail_img_5.jpg",
         "https://www.hyundai-wia.com/img/business/auto_engine_detail_img_5.jpg"
        ]
    ]

    static let mockOption = [
        [
            [OptionCardInfo.init(title: "디젤 2.2",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 37%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "2WD",
                                 subTitle: "구매자의 72%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "4WD",
                                 subTitle: "구매자의 82%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "7인승",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "8인승",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "LK-99 3.8",
                                 subTitle: "구매자의 88%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "LK-99 3.8",
                                 subTitle: "구매자의 12%가 선택한",
                                 priceString: "+ 3,456,789원")]
        ],
        [
            [OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원",
                                 isSelected: true),
             OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 3,456,789원")],
            [OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 0 원",
                                 isSelected: true),
             OptionCardInfo.init(title: "가솔린 3.8",
                                 subTitle: "구매자의 63%가 선택한",
                                 priceString: "+ 0 원")]
        ]
    ]
}
