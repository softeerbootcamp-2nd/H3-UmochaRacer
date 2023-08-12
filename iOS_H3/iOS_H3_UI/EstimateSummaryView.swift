//
//  EstimateSummaryView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class EstimateSummaryView: UIView {

    // MARK: - UI properties

    private let imageView = UIImageView()

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupViews()
    }

    // MARK: - Helpers

    func configure(_ data: Int) {
        print("[EstimateSummaryView]", #function, "// 데이터 타입 수정하고 메소드 구현 필요")
    }
}

extension EstimateSummaryView {
    private func setupViews() {
        let image = UIImage(named: "temp_estimateSummary")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
