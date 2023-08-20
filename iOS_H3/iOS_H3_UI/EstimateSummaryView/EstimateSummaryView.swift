//
//  EstimateSummaryView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class EstimateSummaryView: UIScrollView {

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

    func configure(_ data: EstimateSummary) {
        print("[EstimateSummaryView]", #function, " \(data) // 메소드 구현 필요")
    }
}

// MARK: - Setup

extension EstimateSummaryView {

    private func setupViews() {
        let image = UIImage(named: "temp_estimateSummary")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

        addSubview(imageView)
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
