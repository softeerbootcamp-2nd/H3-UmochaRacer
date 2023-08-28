//
//  DetailInfoEntity.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/21.
//

import Foundation
import Combine

struct DetailOptionEntity {
    let title: String
    let description: String
    let info: String?
    let imageSrc: String?
}

extension DetailOptionEntity {
    func toPresentation() -> DetailOptionInfo {

        let titleUR = title.toURString()
        let descriptionUR = description.toURString()
        let infoUR = self.extractDetails(from: info ?? "")
        return DetailOptionInfo(
            title: titleUR,
            description: descriptionUR,
            info: infoUR,
            imageSrc: self.imageSrc
        )
    }

    func extractDetails(from input: String) -> [[String: String]] {
        let regexPattern = "\\[?\\{\"title\": \"(.*?)\", \"description\": \"(.*?)\"\\}\\]?"

        guard let regex = try? NSRegularExpression(pattern: regexPattern) else { return [] }

        let nsInput = input as NSString
        let matches = regex.matches(in: input,
                                    options: [],
                                    range: NSRange(location: 0, length: nsInput.length))

        var result = [[String: String]]()

        for match in matches {
            let titleRange = match.range(at: 1)
            let descriptionRange = match.range(at: 2)
            let titleString = nsInput.substring(with: titleRange)
                .replacingOccurrences(of: "<(?!(/)?cardb>)[^>]+>",
                                      with: "",
                                      options: .regularExpression,
                                      range: nil)
            let descriptionString = nsInput.substring(with: descriptionRange)
                .replacingOccurrences(of: "<(?!(/)?cardb>)[^>]+>",
                                      with: "",
                                      options: .regularExpression,
                                      range: nil)
            result.append(["title": titleString,
                           "description": descriptionString])
        }
        return result
    }
}

enum DetailOptionToEntityError: LocalizedError {
    case missingTitle
    case missingDescription

    var errorDescription: String? {
        switch self {
        case .missingTitle:
            return "제목 값이 없습니다."
        case .missingDescription:
            return "설명 값이 없습니다."
        }
    }
}
