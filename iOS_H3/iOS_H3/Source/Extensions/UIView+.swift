//
//  UIView+.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/14.
//

import UIKit

extension UIView {
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
           self.addSubview(activityIndicator)
           activityIndicator.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
           ])
           activityIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        self.subviews.forEach {
            if $0 is UIActivityIndicatorView {
                $0.removeFromSuperview()
            }
        }
    }
}

extension UIView {
    @IBInspectable var mainHyundaiBlue: Bool {
           get { return backgroundColor == Colors.mainHyundaiBlue }
           set { backgroundColor = newValue ? Colors.mainHyundaiBlue : backgroundColor }
       }

       @IBInspectable var subActiveBlue: Bool {
           get { return backgroundColor == Colors.subActiveBlue }
           set { backgroundColor = newValue ? Colors.subActiveBlue : backgroundColor }
       }

       @IBInspectable var iconYellow: Bool {
           get { return backgroundColor == Colors.iconYellow }
           set { backgroundColor = newValue ? Colors.iconYellow : backgroundColor }
       }

       @IBInspectable var tagSkyBlue: Bool {
           get { return backgroundColor == Colors.tagSkyBlue }
           set { backgroundColor = newValue ? Colors.tagSkyBlue : backgroundColor }
       }

       @IBInspectable var coolGreyBlack: Bool {
           get { return backgroundColor == Colors.coolGreyBlack }
           set { backgroundColor = newValue ? Colors.coolGreyBlack : backgroundColor }
       }

       @IBInspectable var coolGrey4: Bool {
           get { return backgroundColor == Colors.coolGrey4 }
           set { backgroundColor = newValue ? Colors.coolGrey4 : backgroundColor }
       }

       @IBInspectable var coolGrey3: Bool {
           get { return backgroundColor == Colors.coolGrey3 }
           set { backgroundColor = newValue ? Colors.coolGrey3 : backgroundColor }
       }

       @IBInspectable var coolGrey2: Bool {
           get { return backgroundColor == Colors.coolGrey2 }
           set { backgroundColor = newValue ? Colors.coolGrey2 : backgroundColor }
       }

       @IBInspectable var coolGrey1: Bool {
           get { return backgroundColor == Colors.coolGrey1 }
           set { backgroundColor = newValue ? Colors.coolGrey1 : backgroundColor }
       }

       @IBInspectable var currentDotColorOfDotIndicator: Bool {
           get { return backgroundColor == Colors.currentDotColorOfDotIndicator }
           set { backgroundColor = newValue ? Colors.currentDotColorOfDotIndicator : backgroundColor }
       }

       @IBInspectable var defaultDotColorOfDotIndicator: Bool {
           get { return backgroundColor == Colors.defaultDotColorOfDotIndicator }
           set { backgroundColor = newValue ? Colors.defaultDotColorOfDotIndicator : backgroundColor }
       }
}
