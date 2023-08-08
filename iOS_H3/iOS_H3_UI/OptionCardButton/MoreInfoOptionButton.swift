//
//  MoreInfoOptionButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import Foundation
import UIKit
// 자세히보기 옵션 버튼
class MoreInfoOptionButton: OptionCardButton {
    private let moreInfoButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(named: "arrow_right_img") ?? .remove, for: .normal)
        return button
    }()

    override init(type: OptionCardButton.OptionCardType,
                  optionTitle: String = "옵션 타이틀",
                  optionSubTitle: String = "옵션 서브 타이틀",
                  price: String = "+ 0원") {
        super.init(type: type)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.addSubview(moreInfoButton)
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false

        moreInfoButton.widthAnchor.constraint(equalToConstant: 18).isActive = true
        moreInfoButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        moreInfoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18).isActive = true
        moreInfoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

    }

}
