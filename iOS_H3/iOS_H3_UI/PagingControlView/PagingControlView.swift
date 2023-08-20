//
//  PagingControlView.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/20.
//

import UIKit

protocol PagingControlViewDelegate: AnyObject {
    func didTapPreviousButton()
    func didTapNextButton()
}

class PagingControlView: UIView {
    
    // MARK: - UI properties
    
    private let previousButtonView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let nextButtonView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let previousLabel: UILabel = {
        let label = UILabel()
        label.text = "이전"
        label.textColor = Colors.coolGrey3
        return label
    }()
    
    private let nextLabel: UILabel = {
        let label = UILabel()
        label.text = "다음"
        label.textColor = Colors.coolGrey3
        return label
    }()
    
    private let previousImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.left")
        imageView.tintColor = Colors.coolGrey3
        return imageView
    }()
    
    private let nextImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = Colors.coolGrey3
        return imageView
    }()
    // MARK: - Properties
    weak var delegate: PagingControlViewDelegate?
 
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        return control
    }()

    private var currentPage: Int = 0 {
           didSet {
               pageControl.currentPage = currentPage
           }
       }

    private var numberOfPages: Int = 0 {
        didSet {
            pageControl.numberOfPages = numberOfPages
        }
    }

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
    @objc private func handlePreviousButtonTap() {
        if currentPage > 0 {
            currentPage -= 1
            delegate?.didTapPreviousButton()
        }
    }

    @objc private func handleNextButtonTap() {
        if currentPage < numberOfPages - 1 {
            currentPage += 1
            delegate?.didTapNextButton()
        }
    }

    func setNumberOfPages(_ count: Int) {
        numberOfPages = count
    }

    func setCurrentPage(_ page: Int) {
        currentPage = page
    }
}

extension PagingControlView{
    private func setupViews() {
        addSubViews()
        setupPageControl()
        setupGestures()
        setupConstraints()
    }

    private func addSubViews() {
        addSubview(previousButtonView)
        addSubview(nextButtonView)
        
        previousButtonView.addSubview(previousLabel)
        previousButtonView.addSubview(previousImageView)
        nextButtonView.addSubview(nextLabel)
        nextButtonView.addSubview(nextImageView)
    }

    private func setupPageControl() {
        addSubview(pageControl)
    }

    private func setupGestures() {
        let previousTapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePreviousButtonTap))
        previousButtonView.addGestureRecognizer(previousTapGesture)
        
        let nextTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleNextButtonTap))
        nextButtonView.addGestureRecognizer(nextTapGesture)
    }

    private func setupConstraints() {
        disableAutoresizingMasks()
        
        NSLayoutConstraint.activate([
            previousButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previousButtonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            previousButtonView.widthAnchor.constraint(equalToConstant: 80),
            previousButtonView.heightAnchor.constraint(equalToConstant: 40),
            
            nextButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nextButtonView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextButtonView.widthAnchor.constraint(equalToConstant: 80),
            nextButtonView.heightAnchor.constraint(equalToConstant: 40),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            previousImageView.leadingAnchor.constraint(equalTo: previousButtonView.leadingAnchor),
            previousImageView.centerYAnchor.constraint(equalTo: previousButtonView.centerYAnchor),
            
            nextImageView.trailingAnchor.constraint(equalTo: nextButtonView.trailingAnchor, constant: 0),
            nextImageView.centerYAnchor.constraint(equalTo: nextButtonView.centerYAnchor),
            
            previousLabel.leadingAnchor.constraint(equalTo: previousImageView.trailingAnchor, constant: 5),
            previousLabel.centerYAnchor.constraint(equalTo: previousButtonView.centerYAnchor),
            
            nextLabel.trailingAnchor.constraint(equalTo: nextImageView.leadingAnchor),
            nextLabel.centerYAnchor.constraint(equalTo: nextButtonView.centerYAnchor)
        ])
    }

    private func disableAutoresizingMasks() {
        previousButtonView.translatesAutoresizingMaskIntoConstraints = false
        nextButtonView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        previousLabel.translatesAutoresizingMaskIntoConstraints = false
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        previousImageView.translatesAutoresizingMaskIntoConstraints = false
        nextImageView.translatesAutoresizingMaskIntoConstraints = false
    }

}
