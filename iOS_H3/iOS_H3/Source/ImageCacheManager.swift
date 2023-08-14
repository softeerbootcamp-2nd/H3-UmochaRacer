//
//  ImageCacheManager.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//

import Foundation
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func setObject(_ image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }

    func object(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
}
