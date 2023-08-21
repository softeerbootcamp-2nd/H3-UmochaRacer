//
//  DetailPopupUsecaseProtocol.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Combine
import Foundation

protocol DetailPopupUsecaseProtocol {
    func fetchDetailInfo(forPage page: Int) -> AnyPublisher<DetailInfo, Never>
}

class MockDetailPopupUsecase : DetailPopupUsecaseProtocol{
    func fetchDetailInfo(forPage page: Int) -> AnyPublisher<DetailInfo, Never> {
        let detailInfo: DetailInfo
        switch page {
        case 0:
            detailInfo = DetailInfo(title: "Title Page 0", subTitle: "Subtitle Page 0", description: "Description for page 0", additionalInfo: "Additional Info for page 0", imageURL: URL(string: "https://example.com/image0.jpg"))
        case 1:
            detailInfo = DetailInfo(title: "Title Page 1", subTitle: "Subtitle Page 1", description: "Description for page 1", additionalInfo: "Additional Info for page 1", imageURL: URL(string: "https://example.com/image1.jpg"))
        case 2:
            detailInfo = DetailInfo(title: "Title Page 2", subTitle: "Subtitle Page 2", description: "Description for page 2", additionalInfo: "Additional Info for page 2", imageURL: URL(string: "https://example.com/image2.jpg"))
        default:
            detailInfo = DetailInfo(title: "", subTitle: "", description: "", additionalInfo: "", imageURL: nil)
        }
        
        return Just(detailInfo).eraseToAnyPublisher()
    }
    
    
}
