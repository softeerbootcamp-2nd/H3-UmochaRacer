//
//  CarMakingContentView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/10.
//

import UIKit

protocol CarMakingContentViewDataSource: AnyObject {
    func carMakingContentView(urlForItemAtIndex indexPath: IndexPath) -> String?
    func carMakingContentView(optionsForItemAtIndex indexPath: IndexPath) -> [OptionCardInfo]?
}

// 섹션을 정의하기 위한 기본 인터페이스
protocol CarMakingSectionType: Hashable {
    associatedtype Item: Hashable
    var range: Range<Int> { get }
    static func section(for index: Int) -> Self
    func itemIndex(for globalIndex: Int) -> Int
    static var allCases: [Self] { get }
}

class CarMakingContentView<Section: CarMakingSectionType>: UIView, UICollectionViewDelegateFlowLayout {

    let progressBarHeight = 26.0
    let bottomSheetHeight = 129.0

    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, CarMakingStep>!

    weak var dataSource: CarMakingContentViewDataSource? {
        didSet {
            setupSnapshot()
        }
    }

    private let carMakingMode: CarMakingMode
    private let cellIdentifiers: [PageSection: String] = [
        .twoButton: CarMakingTwoOptionCell.identifier,
        .multipleButton: CarMakingMultipleOptionCell.identifier
    ]

    // MARK: - UI properties

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    private let carMakingProgressBar: CarMakingProgressBar = {
        let progressBar = CarMakingProgressBar()
        return progressBar
    }()

    // MARK: - Properties

    private let flowLayoutDelegate = FlowLayoutDelegate()

    // MARK: - Lifecycles

    override init(frame: CGRect) {
        carMakingMode = .selfMode
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        carMakingMode = .selfMode
        super.init(coder: coder)
        setupViews()
    }

    init(frame: CGRect, mode: CarMakingMode) {
        carMakingMode = mode
        super.init(frame: frame)
        setupViews()
    }

    // MARK: - Helpers
}

extension CarMakingContentView {

    private func setupViews() {
        setupProgressBar()
        setupCollectionView()
    }

    private func setupProgressBar() {
        addSubview(carMakingProgressBar)
        carMakingProgressBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carMakingProgressBar.topAnchor.constraint(equalTo: topAnchor),
            carMakingProgressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            carMakingProgressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            carMakingProgressBar.heightAnchor.constraint(equalToConstant: progressBarHeight)
        ])

        carMakingProgressBar.progressBarDelegate = self
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: carMakingProgressBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        configureCollectionViewLayout()
        registerCollectionViewCells()
        setupCollectionViewDataSource()
        collectionView.delegate = flowLayoutDelegate
        setupSnapshot()
    }

    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

    private func registerCollectionViewCells() {
        collectionView.register(CarMakingTwoOptionCell.self,
                                forCellWithReuseIdentifier: CarMakingTwoOptionCell.identifier)
        collectionView.register(CarMakingMultipleOptionCell.self,
                                forCellWithReuseIdentifier: CarMakingMultipleOptionCell.identifier)
    }

     func setupCollectionViewDataSource() {
         collectionViewDataSource = UICollectionViewDiffableDataSource<Section, CarMakingStep>(
            collectionView: collectionView
         ) { [weak self] (collectionView, indexPath, step)
                  -> UICollectionViewCell? in
            let section = PageSection.allCases[indexPath.section]
            guard let self,
                  let cellIdentifier = cellIdentifiers[section],
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                                for: indexPath) as? CarMakingCollectionViewCell else {
                return CarMakingCollectionViewCell()
            }

            let urlString = self.dataSource?.carMakingContentView(urlForItemAtIndex: indexPath)
            let options = self.dataSource?.carMakingContentView(optionsForItemAtIndex: indexPath) ?? []
            cell.configure(mode: self.carMakingMode,
                           bannerImage: urlString,
                           makingStepTitle: step.title,
                           optionInfos: options)
            return cell
        }

    }

    func setupSnapshot() {
        let steps = CarMakingStep.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, CarMakingStep>()
        for section in Section.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(Array(steps[section.range]), toSection: section)
        }
        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: : UICollectionViewDelegateFlowLayout
class FlowLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    let progressBarHeight = 26.0

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGSize(width: collectionView.frame.width, height: collectionView.frame.height - progressBarHeight)
        return height
    }
}

extension CarMakingContentView: CarMakingProgressBarDelegate {
    func progressBarButtonDidTapped(didSelectItemAt index: Int) {
        let section = PageSection.section(for: index)
        let item = section.itemIndex(for: index)
        let sectionIndex = PageSection.allCases.firstIndex(of: section)!
        let indexPath = IndexPath(item: item, section: sectionIndex)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
