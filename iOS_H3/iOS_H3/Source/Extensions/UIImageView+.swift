//
//  UIImageView+.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//


import UIKit

extension UIImageView {
    private var activityIndicator: UIActivityIndicatorView? {
        return self.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    private func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        activityIndicator?.removeFromSuperview()
    }
    
    func loadCachedImage(of key: String, showLoading: Bool = true) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: key as NSString) {
            self.image = cachedImage
            return
        }

        if showLoading {
            showLoadingIndicator()
        }

        guard let url = URL(string: key),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { return }

        urlComponents.scheme = "https"
        guard let imageURL = urlComponents.url else { return }

        let task = URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let data = data, let loadedImage = UIImage(data: data), error == nil else { return }
            
            ImageCacheManager.shared.setObject(loadedImage, forKey: key as NSString)
            
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                self?.image = loadedImage
            }
        }
        task.resume()
    }
}
