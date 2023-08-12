//
//  MultiOptionCardButtonView.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/09.
//

import UIKit
import Combine

protocol MultiOptionCardButtonViewDelegate: AnyObject {
    func optionCardButtonDidTapped(index: Int)
}

final class MultiOptionCardButtonView: UIView, OptionCardButtonListViewable {
    
    enum Constants {
        static let cellHeight = 150.0
        static let optionCardCollectionViewHeight = 150.0
        static let spacing = 10.0
        static let dotIndicatorHeight = 8.0
        static let currentDotIndicatorColor = "2B2F36"
        static let dotIndicatorColor = "D9D9D9"
    }
    
    enum Section {
        case optionCard
    }
    
    typealias OptionCardCollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<Section, OptionCardInfo>
    
    // MARK: - UI properties
    
    private var optionCardCollectionView: UICollectionView!
    
    private var dotIndicator = UIPageControl()

    // MARK: - Properties
    
    private let optionCardType: OptionCardButton.OptionCardType

    private var dataSource: OptionCardCollectionViewDiffableDataSource!
    
    private var buttonTapCancellableByIndex: [Int: AnyCancellable] = [:]

    weak var delegate: MultiOptionCardButtonViewDelegate?

    // MARK: - Lifecycles
    
    init(frame: CGRect = .zero, type: OptionCardButton.OptionCardType) {
        optionCardType = type
        super.init(frame: frame)
        
        setupOptionCardCollectionView()
        setupViews()
    }
    
    override init(frame: CGRect) {
        optionCardType = .selfMode
        super.init(frame: frame)
        
        setupOptionCardCollectionView()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        optionCardType = .selfMode
        super.init(coder: coder)
        
        setupOptionCardCollectionView()
        setupViews()
    }
    
    // MARK: - Helpers

    func updateAllViews(with cardInfos: [OptionCardInfo]) {
        dotIndicator.numberOfPages = cardInfos.count
        updateSnapshot(item: cardInfos)
    }
}

extension MultiOptionCardButtonView: OptionCardButtonDelegate {

    func moreInfoButtonDidTapped() {
        print("[MultiOptionCardButtonView]", #function, "- show alert 구현 필요")
    }
}

// MARK: - Setup CollectionView

extension MultiOptionCardButtonView {

    private func setupOptionCardCollectionView() {
        optionCardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        optionCardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        optionCardCollectionView.isScrollEnabled = true
        optionCardCollectionView.bounces = false
        
        registerCollectionViewCell()
        setupCollectionViewDataSource()
        setupSnapshot()
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Constants.cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        connectDotIndicator(with: section)

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func connectDotIndicator(with section: NSCollectionLayoutSection) {
        section.visibleItemsInvalidationHandler = { [weak self] (_, offset, _) in
            guard let self else { return }
            let page = Int(round(offset.x / self.bounds.width))
            dotIndicator.currentPage = page
        }
    }

    private func registerCollectionViewCell() {
        optionCardCollectionView.register(OptionCardCell.self, forCellWithReuseIdentifier: OptionCardCell.identifier)
    }

    private func setupCollectionViewDataSource() {
        dataSource = OptionCardCollectionViewDiffableDataSource(collectionView: optionCardCollectionView) { [weak self] (collectionView, indexPath, item) in
            guard let self,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCardCell.identifier, for: indexPath) as? OptionCardCell else {
                return OptionCardCell()
            }
            
            cell.configure(cardType: optionCardType, info: item)
            
            buttonTapCancellableByIndex[indexPath.row] = cell.buttonTapSubject
                .sink { [weak self] in
                    guard let self else { return }
                    delegate?.optionCardButtonDidTapped(index: indexPath.row)
                }
            
            return cell
        }
    }

    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, OptionCardInfo>()
        snapshot.appendSections([Section.optionCard])
        dataSource.apply(snapshot)
    }

    private func updateSnapshot(item: [OptionCardInfo]) {
        var snapshot = dataSource.snapshot()

        let previousItem = snapshot.itemIdentifiers
        snapshot.deleteItems(previousItem)
        snapshot.appendItems(item)

        dataSource.apply(snapshot)
    }
}

// MARK: - Setup

extension MultiOptionCardButtonView {

    private func setupViews() {
        setupDotIndicator()
        addSubviews()
        setupConstraints()
    }

    private func setupDotIndicator() {
        dotIndicator.currentPage = 0
        dotIndicator.currentPageIndicatorTintColor = UIColor(hex: Constants.currentDotIndicatorColor)
        dotIndicator.pageIndicatorTintColor = UIColor(hex: Constants.dotIndicatorColor)
        dotIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func addSubviews() {
        addSubview(optionCardCollectionView)
        addSubview(dotIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            optionCardCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            optionCardCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionCardCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionCardCollectionView.heightAnchor.constraint(equalToConstant: Constants.optionCardCollectionViewHeight)
        ])
        NSLayoutConstraint.activate([
            dotIndicator.topAnchor.constraint(equalTo: optionCardCollectionView.bottomAnchor, constant: Constants.spacing),
            dotIndicator.leadingAnchor.constraint(equalTo: optionCardCollectionView.leadingAnchor),
            dotIndicator.trailingAnchor.constraint(equalTo: optionCardCollectionView.trailingAnchor),
            dotIndicator.heightAnchor.constraint(equalToConstant: Constants.dotIndicatorHeight)
        ])
    }
}
