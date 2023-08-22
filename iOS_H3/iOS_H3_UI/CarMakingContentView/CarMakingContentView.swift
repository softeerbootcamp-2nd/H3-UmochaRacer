//
//  CarMakingContentView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/10.
//

import UIKit
import Combine

protocol CarMakingContentViewDelegate: AnyObject {
    func carMakingContentView(stepDidChanged stepIndex: Int)
    func carMakingContentView(optionDidSelectedAt optionIndex: Int, in stepIndex: Int)
    func carMakingContentView(categoryDidSelected category: OptionCategoryType)
}

// 섹션을 정의하기 위한 기본 인터페이스
protocol CarMakingSectionType: Hashable, CaseIterable {
    associatedtype Item: Hashable

    init?(sectionIndex: Int)

    var cellIdentifiers: String { get }
    var range: Range<Int> { get }

    static func section(for index: Int) -> Self
    static func indexPath(for globalIndex: Int) -> IndexPath
}

class CarMakingContentView<Section: CarMakingSectionType>: UIView, UICollectionViewDelegateFlowLayout {

    let progressBarHeight = 26.0
    let bottomSheetHeight = 129.0

    // MARK: - UI properties

    private let carMakingProgressBar: CarMakingProgressBar = {
        let progressBar = CarMakingProgressBar()
        return progressBar
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    // MARK: - Properties

    var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, CarMakingStepInfo>!

    private let flowLayoutDelegate = FlowLayoutDelegate()

    weak var delegate: CarMakingContentViewDelegate?

    private let carMakingMode: CarMakingMode

    private var currentStep: Int = 0 {
        didSet {
            moveStep(to: currentStep)
            delegate?.carMakingContentView(stepDidChanged: currentStep)
        }
    }

    private var optionSelectCancellableByIndexPath = [IndexPath: AnyCancellable]()

    private var optionCategoryTapCancellableByIndexPath = [IndexPath: AnyCancellable]()

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

    func moveNextStep(feedbackTitle: String, feedbackDescription: String) {
        guard currentStep < CarMakingStep.allCases.count - 1 else { return }
        let indexPath = Section.indexPath(for: currentStep)
        if let cell = collectionView.cellForItem(at: indexPath) as? CarMakingCollectionViewCell {
            cell.playFeedbackAnimation(title: feedbackTitle,
                                       description: feedbackDescription,
                                       completion: {[weak self] in
                self?.currentStep += 1
            })
        }
    }

    func movePrevStep() {
        guard currentStep > 0 else { return }
        currentStep -= 1
    }

    func configureCurrentStep(with info: CarMakingStepInfo) {
        updateCollectionViewSnapshot(ofItem: info)
    }

    func updateOptionCard(with info: [OptionCardInfo]) {
        let indexPathOfCurrentStep = Section.indexPath(for: currentStep)
        guard let cell = collectionView.cellForItem(at: indexPathOfCurrentStep) as? CarMakingCollectionViewCell else {
            return
        }
        cell.update(optionInfoArray: info)
    }

    func updateOptionCardForCategory(with info: [OptionCardInfo]) {
        let indexPathOfCurrentStep = Section.indexPath(for: currentStep)
        guard let cell = collectionView.cellForItem(at: indexPathOfCurrentStep) as? CarMakingOptionSelectStepCell else {
            return
        }
        cell.configure(optionInfoArray: info)
    }
}

extension CarMakingContentView {

    private func moveStep(to index: Int) {
        carMakingProgressBar.selectButton(for: index)
        moveCollectionView(to: index)
    }

    private func moveCollectionView(to index: Int) {
        let indexPath = Section.indexPath(for: index)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    private func updateCollectionViewSnapshot(ofItem info: CarMakingStepInfo) {
        var snapshot = collectionViewDataSource.snapshot()

        let indexPathOfCurrentStep = Section.indexPath(for: currentStep)
        guard let section = Section(sectionIndex: indexPathOfCurrentStep.section) else {
            return
        }

        var sectionItems = snapshot.itemIdentifiers(inSection: section)
        snapshot.deleteItems(sectionItems)

        let currentItemIndex = indexPathOfCurrentStep.row
        sectionItems[currentItemIndex] = info

        snapshot.appendItems(sectionItems, toSection: section)
        collectionViewDataSource.apply(snapshot)
    }
}

// MARK: - UICollectionView DelegateFlowLayout

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
        collectionView.register(CarMakingOptionSelectStepCell.self,
                                forCellWithReuseIdentifier: CarMakingOptionSelectStepCell.identifier)
    }

     func setupCollectionViewDataSource() {
         collectionViewDataSource = UICollectionViewDiffableDataSource<Section, CarMakingStepInfo>(
            collectionView: collectionView
         ) { [weak self] (collectionView, indexPath, carMakingStepInfo)
                  -> UICollectionViewCell? in
             guard let section = Section(sectionIndex: indexPath.section),
                   let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: section.cellIdentifiers,
                    for: indexPath
                   ) as? CarMakingCollectionViewCell else {
                 return CarMakingCollectionViewCell()
             }

             cell.configure(carMakingStepInfo: carMakingStepInfo)
             self?.subscribeCellEvent(of: cell, indexPath: indexPath)

             return cell
        }
    }

    private func subscribeCellEvent(of cell: CarMakingCollectionViewCell, indexPath: IndexPath) {
        subscribe(optionSelection: cell.optionDidSelected, indexPath: indexPath)
        if let optionSelectStepCell = cell as? CarMakingOptionSelectStepCell {
            subscribe(optionCategoryTap: optionSelectStepCell.optionCategoryTapSubject, indexPath: indexPath)
        }
    }

    private func subscribe(optionSelection: PassthroughSubject<Int, Never>, indexPath: IndexPath) {
        optionSelectCancellableByIndexPath[indexPath] = optionSelection
            .sink { [weak self] optionIndex in
                guard let self else { return }
                delegate?.carMakingContentView(optionDidSelectedAt: optionIndex, in: currentStep)
            }
    }

    private func subscribe(optionCategoryTap: PassthroughSubject<OptionCategoryType, Never>, indexPath: IndexPath) {
        optionCategoryTapCancellableByIndexPath[indexPath] = optionCategoryTap
            .sink { [weak self] category in
                self?.delegate?.carMakingContentView(categoryDidSelected: category)
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
