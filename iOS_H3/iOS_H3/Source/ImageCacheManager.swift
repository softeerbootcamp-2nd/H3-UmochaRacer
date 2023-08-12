//
//  ImageCacheManager.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()

    func setObject(_ image: UIImage, forKey key: NSString) {
        ImageCacheManager.shared.setObject(image, forKey: key)
    }

    func object(forKey key: NSString) -> UIImage? {
        return ImageCacheManager.shared.object(forKey: key)
    }
}
