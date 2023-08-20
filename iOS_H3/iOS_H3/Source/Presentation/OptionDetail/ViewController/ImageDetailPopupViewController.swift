//
//  ImageDetailPopupViewController.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import UIKit

class ImageDetailPopupViewController: UIViewController {

    @IBOutlet weak var optionImageView: UIImageView!
    
    @IBOutlet weak var exitButton: UIButton!

    @IBOutlet weak var subTitleLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var additionalInfoContainerView: UIView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    @IBOutlet weak var infoContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var pageControlContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    // MARK: - Helpers
    
    @IBAction func didTapExitButton(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
}

extension ImageDetailPopupViewController{
    private func setupViews(){
        setupFonts()
        setupColors()
        setupPagingControlView(pageCount: 3)
    }
    
    private func setupFonts(){
        self.subTitleLabel.font = Fonts.regularTitle6
        self.titleLabel.font = Fonts.mediumTitle4
        self.descriptionTextView.font = Fonts.regularBody2
        additionalInfoLabel.font = Fonts.regularBody2
    }
    
    private func setupColors(){
        additionalInfoContainerView.backgroundColor = Colors.coolGrey1
        self.subTitleLabel.textColor = Colors.coolGrey3
        additionalInfoLabel.textColor = Colors.coolGrey4
    }
    
    private func setupPagingControlView(pageCount : Int) {
        let pagingControlView = PagingControlView(frame: .zero)
        pageControlContainerView.addSubview(pagingControlView)
        pagingControlView.setCurrentPage(0)
        pagingControlView.setNumberOfPages(pageCount)
        pagingControlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingControlView.topAnchor.constraint(equalTo: pageControlContainerView.topAnchor),
            pagingControlView.bottomAnchor.constraint(equalTo: pageControlContainerView.bottomAnchor),
            pagingControlView.leadingAnchor.constraint(equalTo: pageControlContainerView.leadingAnchor),
            pagingControlView.trailingAnchor.constraint(equalTo: pageControlContainerView.trailingAnchor)
        ])
    }
}

