//
//  CarMakingEstimateCell.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/28.
//

import UIKit
import Combine

class CarMakingEstimateCell: CarMakingCollectionViewCell {

    static let identifier = "CarMakingEstimateCell"

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let carImageContainerView = UIView()
    private let carImageTitleLabel = UILabel()
    private let carImageView = UIImageView()
    private let estimateSummaryView = EstimateSummaryView()
    private let buttonContainerView = UIView()
    private let exteriorButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "외부")
    private let interiorButton = OhMyCarSetButton(colorType: .coolGrey1, title: "내부")
    private let purchaseConsultationButton = OhMyCarSetButton(colorType: .mainHyundaiBlue, title: "구매 상담 신청")
    private let testDriveButton = OhMyCarSetButton(colorType: .white, title: "시승 신청하기")
    private let shareButton = OhMyCarSetButton(colorType: .grey, title: "공유하기")
    private let saveButton = OhMyCarSetButton(colorType: .grey, title: "저장하기")
    // swiftlint:disable:next line_length
    private var exteriorOption = OptionCardInfo(id: 1, title: URString(fullText: "어비스 블랙펄"), subTitle: URString(fullText: ""), priceString: "0원", bannerImageURL: URL(string: "https://h3cardb.s3.ap-northeast-2.amazonaws.com/exterior_color/%E1%84%8B%E1%85%A5%E1%84%87%E1%85%B5%E1%84%89%E1%85%B3+%E1%84%87%E1%85%B3%E1%86%AF%E1%84%85%E1%85%A2%E1%86%A8+%E1%84%91%E1%85%A5%E1%86%AF+%E1%84%8E%E1%85%A1%E1%84%85%E1%85%A3%E1%86%BC.png"))
    // swiftlint:disable:next line_length
    private var interiorOption = OptionCardInfo(id: 1, title: URString(fullText: "어비스 블랙펄"), subTitle: URString(fullText: ""), priceString: "0원", bannerImageURL: URL(string: "https://h3cardb.s3.ap-northeast-2.amazonaws.com/interior_color/%E1%84%82%E1%85%A2%E1%84%8C%E1%85%A1%E1%86%BC_%E1%84%8F%E1%85%AF%E1%86%AF%E1%84%90%E1%85%B5%E1%86%BC%E1%84%8E%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%A7%E1%86%AB_%E1%84%87%E1%85%B3%E1%86%AF%EB%9E%99_%E1%84%8E%E1%85%A1.png"))

    private lazy var optionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    // MARK: - Constants
    private struct Dimensions {
        static let carImageContainerHeight: CGFloat = 380
        static let carImageHeight: CGFloat = 190
        static let estimateSummaryHeight: CGFloat = 300
        static let buttonContainerHeight: CGFloat = 225
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func configure(with summary: EstimateSummary) {
        estimateSummaryView.configure(summary)
    }

    func configure(info: [OptionCardInfo]) {
        for option in info {
            if option.color != nil {
                self.exteriorOption = option
            }
            if option.iconImageURL != nil {
                self.interiorOption = option
            }
        }
        toggleExteriorInterior(isExteriorSelected: true)
        updateCarImage()
    }

    private func setupUI() {
        configureSubviews()
        configureAutoLayout()
        configureButtons()
    }

    private func configureSubviews() {
        self.optionButtonListView.isHidden = true
        self.descriptionLabel.isHidden = true

        carImageContainerView.addSubview(carImageTitleLabel)
        carImageContainerView.addSubview(carImageView)
        carImageContainerView.addSubview(exteriorButton)
        carImageContainerView.addSubview(interiorButton)
        buttonContainerView.addSubview(purchaseConsultationButton)
        buttonContainerView.addSubview(testDriveButton)
        buttonContainerView.addSubview(shareButton)
        buttonContainerView.addSubview(saveButton)

        scrollView.addSubview(carImageContainerView)
        scrollView.addSubview(estimateSummaryView)
        scrollView.addSubview(buttonContainerView)
        contentView.addSubview(scrollView)

        carImageTitleLabel.text = "나를 위한 펠리세이드가 완성되었어요!"
        carImageTitleLabel.font = Fonts.mediumTitle1
        carImageTitleLabel.numberOfLines = 0
        carImageTitleLabel.textAlignment = .center
        carImageTitleLabel.textColor = Colors.coolGreyBlack

        carImageView.contentMode = .scaleAspectFit

        estimateSummaryView.isScrollEnabled = false

    }

    private func configureAutoLayout() {
        [scrollView,
         carImageContainerView,
         carImageTitleLabel,
         carImageView,
         estimateSummaryView,
         buttonContainerView,
        exteriorButton,
         interiorButton,
         purchaseConsultationButton,
         testDriveButton,
         shareButton,
         saveButton
        ]
            .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            carImageContainerView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            carImageContainerView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            carImageContainerView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            carImageContainerView.heightAnchor.constraint(equalToConstant: Dimensions.carImageContainerHeight),

            carImageTitleLabel.topAnchor.constraint(equalTo: carImageContainerView.topAnchor, constant: 26),
            carImageTitleLabel.leadingAnchor.constraint(equalTo: carImageContainerView.leadingAnchor, constant: 92),
            carImageTitleLabel.trailingAnchor.constraint(equalTo: carImageContainerView.trailingAnchor, constant: -92),

            carImageView.topAnchor.constraint(equalTo: carImageTitleLabel.bottomAnchor, constant: 10),
            carImageView.leadingAnchor.constraint(equalTo: carImageContainerView.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: carImageContainerView.trailingAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: Dimensions.carImageHeight),

            estimateSummaryView.topAnchor.constraint(equalTo: carImageContainerView.bottomAnchor),
            estimateSummaryView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            estimateSummaryView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            estimateSummaryView.heightAnchor.constraint(equalToConstant: Dimensions.estimateSummaryHeight),

            buttonContainerView.topAnchor.constraint(equalTo: estimateSummaryView.bottomAnchor),
            buttonContainerView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            buttonContainerView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            buttonContainerView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            buttonContainerView.heightAnchor.constraint(equalToConstant: Dimensions.buttonContainerHeight)
        ])

        NSLayoutConstraint.activate([
            exteriorButton.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 24),
            exteriorButton.leadingAnchor.constraint(equalTo: carImageContainerView.leadingAnchor, constant: 100),
            exteriorButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            interiorButton.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 24),
            interiorButton.leadingAnchor.constraint(equalTo: exteriorButton.trailingAnchor, constant: 0),
            interiorButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
            interiorButton.widthAnchor.constraint(equalTo: exteriorButton.widthAnchor, multiplier: 1.0),
            interiorButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            purchaseConsultationButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor),
            purchaseConsultationButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor,
                                                                constant: 16),
            purchaseConsultationButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor,
                                                                 constant: -16),
            purchaseConsultationButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            testDriveButton.topAnchor.constraint(equalTo: purchaseConsultationButton.bottomAnchor, constant: 9),
            testDriveButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 16),
            testDriveButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -16),
            testDriveButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: testDriveButton.bottomAnchor, constant: 9),
            shareButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor, constant: 16),
            shareButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -12),
            shareButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: testDriveButton.bottomAnchor, constant: 9),
            saveButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }

    private func configureButtons() {
        exteriorButton.addTarget(self, action: #selector(exteriorButtonTapped), for: .touchUpInside)
        interiorButton.addTarget(self, action: #selector(interiorButtonTapped), for: .touchUpInside)
    }

    @objc private func exteriorButtonTapped() {
        toggleExteriorInterior(isExteriorSelected: true)
    }

    @objc private func interiorButtonTapped() {
        toggleExteriorInterior(isExteriorSelected: false)
    }

    private func toggleExteriorInterior(isExteriorSelected: Bool) {
        exteriorButton.colorType = isExteriorSelected ? .mainHyundaiBlue : .coolGrey1
        interiorButton.colorType = isExteriorSelected ? .coolGrey1 : .mainHyundaiBlue
        updateButtonStyles(for: exteriorButton)
        updateButtonStyles(for: interiorButton)
        updateCarImage()
    }

    private func updateCarImage() {
        var selectedImageURL: URL?

        if exteriorButton.colorType == .mainHyundaiBlue, let exteriorImageURL = exteriorOption.bannerImageURL {
            selectedImageURL = exteriorImageURL
        } else if interiorButton.colorType == .mainHyundaiBlue, let interiorImageURL = interiorOption.bannerImageURL {
            selectedImageURL = interiorImageURL
        }
        guard let imageURL = selectedImageURL else { return }
        self.carImageView.loadCachedImage(of: imageURL)
    }

    private func updateButtonStyles(for button: OhMyCarSetButton) {
        button.backgroundColor = button.colorType.backgroundColor
        button.setTitleColor(button.colorType.titleColor, for: .normal)
        if button.colorType.hasBorder {
            button.addBorder(width: 1, color: .black)
        } else {
            button.layer.borderWidth = 0
        }
    }
}
