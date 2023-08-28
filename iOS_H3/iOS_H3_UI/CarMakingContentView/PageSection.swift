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
    case optionSelection
    case estimate

    init?(sectionIndex: Int) {
        self.init(rawValue: sectionIndex)
    }

    var cellIdentifiers: String {
        switch self {
        case .twoButton:
            return CarMakingTwoOptionCell.identifier
        case .multipleButton:
            return CarMakingMultipleOptionCell.identifier
        case .optionSelection:
            return CarMakingOptionSelectStepCell.identifier
        case .estimate:
            return CarMakingEstimateCell.identifier
        }
    }

    var range: Range<Int> {
        switch self {
        case .twoButton:
            return 0..<3
        case .multipleButton:
            return 3..<6
        case .optionSelection:
            return 6..<7
        case .estimate:
            return 7..<9
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

    private func itemIndex(for globalIndex: Int) -> Int {
        let sectionIndex = PageSection.section(for: globalIndex).rawValue
        var itemIndex = globalIndex
        (0..<sectionIndex).forEach {
            itemIndex -= PageSection.allCases[$0].range.count
        }
        return itemIndex
    }
}
