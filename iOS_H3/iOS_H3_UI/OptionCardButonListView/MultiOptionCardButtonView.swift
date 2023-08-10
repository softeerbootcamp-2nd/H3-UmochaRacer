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
    }
    
    enum Section {
        case optionCard
    }
    
    typealias OptionCardCollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<Section, OptionCardInfo>
    
    // MARK: - UI properties
    
    private var optionCardCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private let optionCardType: OptionCardButton.OptionCardType

    private var dataSource: OptionCardCollectionViewDiffableDataSource!

    private let cellIdentifiers: [OptionCardButton.OptionCardType: String] = [
        .selfMode: SelfModeOptionCardCell.identifier,
        .guideMode: GuideModeOptionCardCell.identifier
    ]
    
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
        var snapshot = dataSource.snapshot()
        
        let previousItem = snapshot.itemIdentifiers
        snapshot.deleteItems(previousItem)
        snapshot.appendItems(cardInfos)
        
        dataSource.apply(snapshot)
    }
}

extension MultiOptionCardButtonView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        buttonTapCancellableByIndex[indexPath.row]?.cancel()
    }
}

// MARK: - Setup

extension MultiOptionCardButtonView {

    private func setupOptionCardCollectionView() {
        optionCardCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        optionCardCollectionView.delegate = self
        optionCardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        optionCardCollectionView.isScrollEnabled = true
        optionCardCollectionView.bounces = false
        
        registerCollectionViewCell()
        setupCollectionViewDataSource()
        setupSnapshot()
    }

    private func setupViews() {
        addSubviews()
        setupConstraints()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(Constants.cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func registerCollectionViewCell() {
        optionCardCollectionView.register(SelfModeOptionCardCell.self, forCellWithReuseIdentifier: SelfModeOptionCardCell.identifier)
        optionCardCollectionView.register(GuideModeOptionCardCell.self, forCellWithReuseIdentifier: GuideModeOptionCardCell.identifier)
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = OptionCardCollectionViewDiffableDataSource(collectionView: optionCardCollectionView) { [weak self] (collectionView, indexPath, item) in
            guard let self,
                  let cellIdentifier = cellIdentifiers[optionCardType],
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? OptionCardCell else {
                return OptionCardCell()
            }
            
            cell.configure(item)
            
            let cancellable = cell.buttonTapSubject
                .sink { [weak self] in
                    guard let self else { return }
                    delegate?.optionCardButtonDidTapped(index: indexPath.row)
                }
            buttonTapCancellableByIndex[indexPath.row] = cancellable
            
            return cell
        }
    }
    
    private func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, OptionCardInfo>()
        snapshot.appendSections([Section.optionCard])
        dataSource.apply(snapshot)
    }

    private func addSubviews() {
        addSubview(optionCardCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            optionCardCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            optionCardCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionCardCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionCardCollectionView.heightAnchor.constraint(equalToConstant: Constants.optionCardCollectionViewHeight)
        ])
    }
}
