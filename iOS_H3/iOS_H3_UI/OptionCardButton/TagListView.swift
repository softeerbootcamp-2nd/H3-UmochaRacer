//
//  TagListView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/06.
//

import Foundation
import UIKit
class TagListView: UIView {

    private let tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    private let tagScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(tagScrollView)
        tagScrollView.translatesAutoresizingMaskIntoConstraints = false
        tagScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tagScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tagScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tagScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        tagScrollView.addSubview(tagStackView)
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.topAnchor.constraint(equalTo: tagScrollView.topAnchor).isActive = true
        tagStackView.bottomAnchor.constraint(equalTo: tagScrollView.bottomAnchor).isActive = true
        tagStackView.leadingAnchor.constraint(equalTo: tagScrollView.leadingAnchor).isActive = true
        tagStackView.trailingAnchor.constraint(equalTo: tagScrollView.trailingAnchor).isActive = true
        tagStackView.heightAnchor.constraint(equalTo: tagScrollView.heightAnchor).isActive = true
    }

    // 태그를 추가하는 메서드
    func addTag(_ tagText: String) {
        let containerView = UIView()
        containerView.backgroundColor = Colors.tagSkyBlue

        let tagLabel = UILabel()
        tagLabel.font = Fonts.regularTitle6
        tagLabel.textColor = Colors.coolGreyBlack
        tagLabel.text = tagText

        containerView.addSubview(tagLabel)
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            tagLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            tagLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            tagLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4)
        ])

        tagStackView.addArrangedSubview(containerView)
    }

    // 여러 태그를 한 번에 추가하는 메서드
    func addTags(_ tags: [String]) {
        tags.forEach { addTag($0) }
    }
}
