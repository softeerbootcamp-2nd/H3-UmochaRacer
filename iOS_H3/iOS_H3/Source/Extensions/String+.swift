//
//  String+.swift
//  iOS_H3
//
//  Created by  sangyeon on 2023/08/21.
//

import Foundation

extension String {
    /// String으로부터 <cardb> 태그로 감싸진 백카사전 단어를 찾고 URString으로 리턴
    func toURString() -> URString {
        let pattern = "<cardb>[^<]+</cardb>"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return URString(fullText: self)
        }

        var string = self
        var ranges = [Range<Int>]()

        while true {
            guard let match = regex.firstMatch(in: string, range: NSRange(location: 0, length: string.count)) else {
                break
            }
            let startIndexOfTarget = string.index(string.startIndex, offsetBy: match.range.lowerBound + 7)
            let endIndexOfTarget = string.index(string.startIndex, offsetBy: match.range.upperBound - 8)
            let targetWordIndexRange = startIndexOfTarget..<endIndexOfTarget

            let targetWord = string[targetWordIndexRange]

            let startIntIndex = match.range.lowerBound
            let targetWordRangeExceptForTag = startIntIndex..<startIntIndex + targetWord.count
            ranges.append(targetWordRangeExceptForTag)

            let startIndexOfReplaced = string.index(string.startIndex, offsetBy: match.range.lowerBound)
            let endIndexOfReplaced = string.index(string.startIndex, offsetBy: match.range.upperBound)
            string.replaceSubrange(startIndexOfReplaced..<endIndexOfReplaced, with: targetWord)
        }
        return URString(fullText: string, cardbRange: ranges)
    }
}
