//
//  ColorViewOptionCardButton.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import Foundation
import UIKit
// 외장 색상 옵션 버튼
class ColorViewOptionCardButton: OptionCardButton {
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = false
        return view
    }()

    override init(type: OptionCardButton.OptionCardType,
                  optionTitle: String = "옵션 타이틀",
                  optionSubTitle: String = "옵션 서브 타이틀",
                  price: String = "+ 0원") {
        super.init(type: type)
        layout()
        attribute()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
        attribute()
    }

    private func layout() {
        self.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28).isActive = true
    }

    private func attribute() {
        colorView.layer.cornerRadius = 30
    }

    func setColor(_ color: UIColor) {
        colorView.backgroundColor = color
    }
}
