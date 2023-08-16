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

protocol CarMakingContentViewDelegate: AnyObject {
    func carMakingContentView(stepDidChanged stepIndex: Int)
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

    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, CarMakingStepInfo>!

    private let flowLayoutDelegate = FlowLayoutDelegate()

    weak var dataSource: CarMakingContentViewDataSource? {
        didSet {
            setupSnapshot()
        }
    }

    weak var delegate: CarMakingContentViewDelegate?

    private let cellIdentifiers: [PageSection: String] = [
        .twoButton: CarMakingTwoOptionCell.identifier,
        .multipleButton: CarMakingMultipleOptionCell.identifier
    ]

    private let carMakingMode: CarMakingMode

    private var currentStep: Int = 0 {
        didSet {
            moveStep(to: currentStep)
            delegate?.carMakingContentView(stepDidChanged: currentStep)
        }
    }

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

    func moveNextStep() {
        guard currentStep < CarMakingStep.allCases.count - 1 else { return }
        currentStep += 1
    }

    func movePrevStep() {
        guard currentStep > 0 else { return }
        currentStep -= 1
    }

    func updateCurrentStepInfo(_ info: CarMakingStepInfo) {
        var snapshot = collectionViewDataSource.snapshot()
        let indexPath = getIndexPathOfCollectionView(currentStep)

        if let section = PageSection.allCases[indexPath.section] as? Section {
            let itemIndex = section.itemIndex(for: currentStep)
            var items = snapshot.itemIdentifiers(inSection: section)
            snapshot.deleteItems(items)

            items[itemIndex] = info
            snapshot.appendItems(items, toSection: section)
        }
        collectionViewDataSource.apply(snapshot)
    }
}

extension CarMakingContentView {

    private func moveStep(to index: Int) {
        carMakingProgressBar.selectButton(for: index)
        moveCollectionView(to: index)
    }

    private func moveCollectionView(to index: Int) {
        let indexPath = getIndexPathOfCollectionView(index)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    private func getIndexPathOfCollectionView(_ index: Int) -> IndexPath {
        let section = PageSection.section(for: index)
        let sectionIndex = section.sectionIndex
        let item = section.itemIndex(for: index)
        return IndexPath(item: item, section: sectionIndex)
    }
}

// MARK: - Setup Views

extension CarMakingContentView {

    private func setupViews() {
        setupProgressBar()
        setupCollectionView()
        currentStep = 0
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
         collectionViewDataSource = UICollectionViewDiffableDataSource<Section, CarMakingStepInfo>(
            collectionView: collectionView
         ) { [weak self] (collectionView, indexPath, carMakingStepInfo)
                  -> UICollectionViewCell? in
             let section = PageSection.allCases[indexPath.section]
             guard let self,
                   let cellIdentifier = cellIdentifiers[section],
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: cellIdentifier,
                    for: indexPath
                   ) as? CarMakingCollectionViewCell else {
                 return CarMakingCollectionViewCell()
             }
             cell.configure(carMakingStepInfo: carMakingStepInfo)
            return cell
        }

    }

    func setupSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CarMakingStepInfo>()
        for section in Section.allCases {
            snapshot.appendSections([section])
            let carMakingStepInfoArray = (section.range).compactMap { stepIndex -> CarMakingStepInfo? in
                guard let step = CarMakingStep(rawValue: stepIndex) else {
                    return nil
                }
                return CarMakingStepInfo(step: step)
            }
            snapshot.appendItems(carMakingStepInfoArray, toSection: section)
        }
        collectionViewDataSource.apply(snapshot, animatingDifferences: true)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

class FlowLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    let progressBarHeight = 26.0

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGSize(width: collectionView.frame.width, height: collectionView.frame.height - progressBarHeight)
        return height
    }
}

// MARK: - CarMakingProgressBar Delegate

extension CarMakingContentView: CarMakingProgressBarDelegate {

    func progressBarButtonDidTapped(didSelectItemAt index: Int) {
        currentStep = index
    }
}
