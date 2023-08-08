//
//  ImageDisplayOptionButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import Foundation
import UIKit
// 내장 색상 옵션 버튼
class ImageDisplayOptionButton: OptionCardButton {
    private let optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = .gray
        return imageView
    }()

    override init(type: OptionCardButton.OptionCardType,
                  optionTitle: String = "옵션 타이틀",
                  optionSubTitle: String = "옵션 서브 타이틀",
                  price: String = "+ 0원") {
        super.init(type: type, optionTitle: optionTitle, optionSubTitle: optionSubTitle, price: price)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.addSubview(optionImageView)
        optionImageView.translatesAutoresizingMaskIntoConstraints = false

        optionImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        optionImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        optionImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 15).isActive = true
        optionImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true

    }

    func setImage(_ image: UIImage?) {
        optionImageView.image = image
    }

}
