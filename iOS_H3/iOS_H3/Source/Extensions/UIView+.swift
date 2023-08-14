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
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.addSubview(activityIndicator)
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
