//
//  CarMakingContentView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/10.
//

import UIKit

class CarMakingContentView: UIView {
    
    enum Constants{
        static let progressBarHeight = 26.0
        static let bottomSheetHeight = 129.0
    }
    
    enum PageSection {
        case twoButton
        case multipleButton
    }

    var dataSource: UICollectionViewDiffableDataSource<PageSection, CarMakingStep>!
    private let optionCardType: OptionCardButton.OptionCardType
    private let cellIdentifiers: [PageSection: String] = [
        .twoButton: CarMakingTwoOptionCell.identifier,
        .multipleButton: CarMakingMultipleOptionCell.identifier
    ]
    // MARK: - UI properties
    
   
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let carMakingProgressBar : CarMakingProgressBar = {
        let progressBar = CarMakingProgressBar()
        return progressBar
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        optionCardType = .selfMode
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        optionCardType = .selfMode
        super.init(coder: coder)
        setupViews()
    }
    init(frame: CGRect, type: OptionCardButton.OptionCardType){
        optionCardType = type
        super.init(frame: frame)
        setupViews()
    }
    
    // MARK: - Helpers
}

extension CarMakingContentView{
    private func setupViews(){
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
            carMakingProgressBar.heightAnchor.constraint(equalToConstant: Constants.progressBarHeight)
        ])
        
        carMakingProgressBar.scrollToIndexHandler = { [weak self] index in

            let section: PageSection = index <= 3 ? .twoButton : .multipleButton
            let indexPath = IndexPath(item: index % 4, section: section == .twoButton ? 0 : 1)
            
            if indexPath.section <= self?.collectionView.numberOfSections ?? 2{
                self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
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
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        setupSnapshot()
    }

    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collectionView.bounds.width,
                                 height: collectionView.bounds.height - Constants.progressBarHeight)
        collectionView.collectionViewLayout = layout
    }

    private func registerCollectionViewCells() {
        collectionView.register(CarMakingTwoOptionCell.self, forCellWithReuseIdentifier: CarMakingTwoOptionCell.identifier)
        collectionView.register(CarMakingMultipleOptionCell.self, forCellWithReuseIdentifier: CarMakingMultipleOptionCell.identifier)
    }

     func setupCollectionViewDataSource(){
         
       
        
        dataSource = UICollectionViewDiffableDataSource<PageSection, CarMakingStep>(collectionView: collectionView) {[weak self] (collectionView, indexPath, step) -> UICollectionViewCell? in
            let section = indexPath.section == 0 ? PageSection.twoButton : PageSection.multipleButton
            guard let self,
                  let cellIdentifier = cellIdentifiers[section],
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CarMakingCollectionViewCell else {
                return CarMakingCollectionViewCell()
            }
            if let url = URL(string: CarMakingContentMockData.mockURL[indexPath.row]){
                let option = CarMakingContentMockData.mockOption[indexPath.row]
                cell.configure(type: .selfMode, bannerImage: url, makingStepTitle: step.title, optionInfos: [option[0], option[1]])
            }

            return cell
        }
        
    }

     func setupSnapshot(){
        let steps = CarMakingStep.allCases
        var snapshot = NSDiffableDataSourceSnapshot<PageSection, CarMakingStep>()
        snapshot.appendSections([.twoButton, .multipleButton])
        snapshot.appendItems(Array(steps[0...3]), toSection: .twoButton)
        snapshot.appendItems(Array(steps[4...7]), toSection: .multipleButton)
        dataSource.apply(snapshot, animatingDifferences: true)

    }
}
extension CarMakingContentView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGSize(width: self.frame.width, height: collectionView.frame.height - Constants.progressBarHeight)
        print(height)
        return height
    }
    
}


struct CarMakingContentMockData {
    static let mockURL = ["https://cdn.autotribune.co.kr/news/photo/202101/4849_30727_3533.jpg",
                   "https://i.namu.wiki/i/cBMX6XiTLltPPIawbb2zfP5Oy5RW9JybY0E5ZQ62oUYdppA2t54xDjiST7xfLe_2dL4pGN9VsBVknq4H-SYA2A.webp",
                   "https://cdn.epnc.co.kr/news/photo/201804/79474_70575_4841.jpg",
                   "https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089982_79.jpg",
                   "https://pimg.daara.co.kr/kidd/photo/2021/01/08/thumbs/thumb_520390_1610089971_11.jpg",
                   "https://itimg.chosun.com/sitedata/image/202112/03/2021120301496_0.jpg",
                   "https://www.hyundai-wia.com/img/business/auto_engine_detail_img_5.jpg"
    ]
     
     static let mockOption =
     [
        [OptionCardInfo.init(title: "디젤 2.2", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 37%가 선택한", priceString:"+ 3,456,789원")],
        [OptionCardInfo.init(title: "2WD", subTitle: "구매자의 72%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "4WD", subTitle: "구매자의 82%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "7인승", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "8인승", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 88%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 12%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 3,456,789원")],
        [OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 0 원", isSelected: true),
         OptionCardInfo.init(title: "가솔린 3.8", subTitle: "구매자의 63%가 선택한", priceString: "+ 0 원")]
     ]
    
}
