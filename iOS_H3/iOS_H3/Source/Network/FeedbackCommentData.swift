//
//  FeedbackCommentData.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/23.
//

import Foundation

enum FeedbackDataToEntityError: LocalizedError {
    case missingComment

    var errorDescription: String? {
        switch self {
        case .missingComment:
            return "comment 정보가 없습니다."
        }
    }
}

struct FeedbackCommentData: Decodable {
    let comment: String?
}
