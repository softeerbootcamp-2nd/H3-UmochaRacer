//
//  UIImageView+.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//


import UIKit

extension UIImageView {
    func loadCachedImage(of key: String, showLoadingIndicator: Bool = true) {

        if let cachedImage = ImageCacheManager.shared.object(forKey: key as NSString) {
            self.image = cachedImage
            return
        }

        if showLoadingIndicator {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            self.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }

        DispatchQueue.global().async {
            guard
                let url = URL(string: key),
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { return }

            urlComponents.scheme = "https"

            guard
                let imageURL = urlComponents.url,
                let imageData = try? Data(contentsOf: imageURL),
                let loadedImage = UIImage(data: imageData)
            else { return }

            ImageCacheManager.shared.setObject(loadedImage, forKey: key as NSString)

            DispatchQueue.main.async { [weak self] in
                if showLoadingIndicator {
                    self?.subviews.forEach { $0.removeFromSuperview() }
                }
                self?.image = loadedImage
            }
        }
    }
}
