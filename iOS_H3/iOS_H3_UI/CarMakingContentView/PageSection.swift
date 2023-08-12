//
//  PageSection.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//

import Foundation
enum PageSection: Int, CarMakingSectionType, CaseIterable{
    typealias Item = Int

    case twoButton = 0
    case multipleButton

    var range: Range<Int> {
        switch self {
        case .twoButton:
            return 0..<4
        case .multipleButton:
            return 4..<8
        }
    }

    static func section(for index: Int) -> PageSection {
        return allCases.first { $0.range.contains(index) } ?? .twoButton
    }

    func itemIndex(for globalIndex: Int) -> Int {
        return globalIndex % self.range.count
    }
}
