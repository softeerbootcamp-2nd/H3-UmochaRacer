//
//  CarMakingContentViewController.swift
//  iOS_H3_UI
//
//  Created by KoJeongMin  on 2023/08/10.
//

import UIKit

final class CarMakingContentViewController: UIViewController {
    
    enum Constants {
        static let inset: CGFloat = 0.0
    }
    
    // MARK: - UI Properties
    
    lazy var selfModeBar: OhMyCarSetTitleBar = {
        let titleBar = OhMyCarSetTitleBar(type: .selfMode)
        titleBar.delegate = self
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        return titleBar
    }()
    
    private lazy var carMakingContentView: CarMakingContentView = {
        let view = CarMakingContentView(frame: .zero, type: .selfMode)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties
    // 여기에 필요한 모델 또는 데이터를 추가할 수 있습니다.

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }

    // MARK: - Helpers
    private func setupViews() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        self.view.addSubview(selfModeBar)
        self.view.addSubview(carMakingContentView)
    }

    private func setupConstraints() {
       
        NSLayoutConstraint.activate([
            selfModeBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            selfModeBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            selfModeBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            selfModeBar.heightAnchor.constraint(equalToConstant: 50),
            
            carMakingContentView.topAnchor.constraint(equalTo: selfModeBar.bottomAnchor, constant: 0),
            carMakingContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.inset),
            carMakingContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.inset),
            carMakingContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

   
}
extension CarMakingContentViewController: OhMyCarSetTitleBarDelegate {
    func titleButtonTapped() {
        print("titleButton Pressed")
    }

    func backButtonPressed() {
        print("backButton Pressed")
        self.dismiss(animated: true)
    }

    func skipButtonPressed() {
        print("skipButton Pressed")
    }

    func dictionaryButtonPressed() {
        print("dictionaryButton Pressed")
    }

    func changeModelButtonPressed() {
        print("changeModelButton Pressed")
    }
}
