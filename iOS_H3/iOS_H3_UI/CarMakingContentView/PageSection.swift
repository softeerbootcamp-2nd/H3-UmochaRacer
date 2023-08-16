//
//  PageSection.swift
//  iOS_H3
//
//  Created by KoJeongMin  on 2023/08/12.
//

import Foundation
enum PageSection: Int, CarMakingSectionType, CaseIterable {
    typealias Item = Int

    case twoButton = 0
    case multipleButton

    var sectionIndex: Int {
        return rawValue
    init?(sectionIndex: Int) {
        self.init(rawValue: sectionIndex)
    }

    var cellIdentifiers: String {
        switch self {
        case .twoButton:
            return CarMakingTwoOptionCell.identifier
        case .multipleButton:
            return CarMakingMultipleOptionCell.identifier
        }
    }

    var range: Range<Int> {
        switch self {
        case .twoButton:
            return 0..<3
        case .multipleButton:
            return 3..<8
        }
    }

    static func section(for index: Int) -> PageSection {
        return allCases.first { $0.range.contains(index) } ?? .twoButton
    }

    static func indexPath(for globalIndex: Int) -> IndexPath {
        let section = section(for: globalIndex)
        let row = section.itemIndex(for: globalIndex)
        return IndexPath(row: row, section: section.rawValue)
    }

    func itemIndex(for globalIndex: Int) -> Int {
        if self == .multipleButton {
            return globalIndex - PageSection.twoButton.range.count
        }
        return globalIndex
    }
}
