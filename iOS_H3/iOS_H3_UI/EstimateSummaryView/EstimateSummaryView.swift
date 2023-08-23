//
//  EstimateSummaryView.swift
//  iOS_H3_UI
//
//  Created by  sangyeon on 2023/08/12.
//

import UIKit

final class EstimateSummaryView: UIScrollView {

    enum Constants {
        static let titleLabelTopOffset = 17.5
        static let labelSideOffset = 20.0
        static let labelHeight = 26.0

        static let collectionViewCellHeight = 18.0
        static let collectionViewHeaderHeight = 38.0
        static let collectionViewSectionInset = UIEdgeInsets(top: 27, left: 0, bottom: 27, right: 0)
        static let collectionViewTopOffset = 36.0
        static let collectionViewItemSpacing = 10.0

        static let collectionViewDefaultHeight = (
            collectionViewHeaderHeight +
            collectionViewSectionInset.top +
            collectionViewSectionInset.bottom
        ) * Double(CarMakingCategory.allCases.count)
    }

    typealias DiffableDataSource = UICollectionViewDiffableDataSource<CarMakingCategory, EstimateSummaryElement>

    // MARK: - UI properties

    private let titleLabel = UILabel()

    private let priceLabel = UILabel()

    private var collectionView: UICollectionView!

    // MARK: - Properties

    private lazy var screenSize = window?.windowScene?.screen.bounds.size ?? UIWindow().screen.bounds.size

    private var dataSource: DiffableDataSource!

    private lazy var collectionViewHeightConstraint = collectionView.heightAnchor.constraint(
        equalToConstant: Constants.collectionViewDefaultHeight
    )

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
        updatePriceLabel(data)
        updateSnapshot(item: data.elements)
        updateCollectionViewHeight(data.elements)
    }
}

extension EstimateSummaryView {

    private func updatePriceLabel(_ estimateSummary: EstimateSummary) {
        let price = estimateSummary.elements.reduce(0) { $0 + $1.price }
        priceLabel.text = String.priceStringWithoutPlus(from: price)
    }

    private func updateSnapshot(item: [EstimateSummaryElement]) {
        var snapshot = dataSource.snapshot()

        let previousItem = snapshot.itemIdentifiers
        snapshot.deleteItems(previousItem)

        item.forEach { element in
            snapshot.appendItems([element], toSection: element.category)
        }

        dataSource.apply(snapshot)
    }

    private func updateCollectionViewHeight(_ item: [EstimateSummaryElement]) {
        var newHeight = Constants.collectionViewDefaultHeight
        newHeight += (Constants.collectionViewCellHeight + Constants.collectionViewItemSpacing) * Double(item.count)
        newHeight -= Double(CarMakingCategory.allCases.count) * Constants.collectionViewItemSpacing

        collectionViewHeightConstraint.constant = newHeight
    }
}

// MARK: - Setup Views

extension EstimateSummaryView {

    private func setupViews() {
        setupUIProperties()
        addSubviews()
        setupConstraints()
    }

    // MARK: - Setup UIProperties

    private func setupUIProperties() {
        setupTitleLabel()
        setupPriceLabel()
        setupCollectionView()
    }

    private func setupTitleLabel() {
        titleLabel.font = Fonts.mediumTitle3
        titleLabel.text = "견적 요약"
        titleLabel.textColor = Colors.coolGreyBlack
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupPriceLabel() {
        priceLabel.font = Fonts.mediumTitle2
        priceLabel.text = "0원"
        priceLabel.textColor = Colors.mainHyundaiBlue
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(EstimateSummaryCell.self, forCellWithReuseIdentifier: EstimateSummaryCell.identifier)
        collectionView.register(
            EstimateSummaryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EstimateSummaryHeaderView.identifier
        )
        setupDataSourceOfCollectionView()
        setupSnapshot()
    }

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: screenSize.width, height: Constants.collectionViewCellHeight)
        flowLayout.minimumInteritemSpacing = Constants.collectionViewItemSpacing
        flowLayout.headerReferenceSize = CGSize(width: screenSize.width, height: Constants.collectionViewHeaderHeight)
        flowLayout.sectionInset = Constants.collectionViewSectionInset
        return flowLayout
    }

    private func setupDataSourceOfCollectionView() {
        configureCollectionViewCell()
        configureCollectionViewHeader()
    }

    private func configureCollectionViewCell() {
        dataSource = DiffableDataSource(
            collectionView: collectionView
        ) { (collectionView, indexPath, item) in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EstimateSummaryCell.identifier,
                for: indexPath
            ) as? EstimateSummaryCell else {
                return EstimateSummaryCell()
            }

            cell.configure(item)

            return cell
        }
    }

    private func configureCollectionViewHeader() {
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            if kind != UICollectionView.elementKindSectionHeader { return nil }

            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: EstimateSummaryHeaderView.identifier,
                for: indexPath
            ) as? EstimateSummaryHeaderView else {
                return EstimateSummaryHeaderView()
            }

            let snapshot = self?.dataSource.snapshot()
            guard let section = snapshot?.sectionIdentifiers[indexPath.section],
                  let sectionItems = snapshot?.itemIdentifiers(inSection: section) else {
                return header
            }
            let price = sectionItems.reduce(0) { $0 + $1.price }

            header.configure(title: section.title, price: price)
            return header
        }
    }

    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<CarMakingCategory, EstimateSummaryElement>()
        snapshot.appendSections(CarMakingCategory.allCases)
        dataSource.apply(snapshot)
    }

    // MARK: - AddSubviews

    private func addSubviews() {
        [titleLabel, priceLabel, collectionView].forEach { addSubview($0) }
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
        setupCollectionViewConstraints()
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.labelSideOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight)
        ])
    }

    private func setupPriceLabelConstraints() {
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.labelSideOffset),
            priceLabel.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        ])
    }

    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: Constants.collectionViewTopOffset
            ),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor),
            collectionViewHeightConstraint
        ])
    }
}
