//
//  SectionOfBasicData.swift
//  Weather
//
//  Created by MyeongJin Kim on 7/26/24.
//

import Foundation
import RxSwift
import RxDataSources


struct SectionOfBasicData {
    var header: String
    var items: [Item]
}

extension SectionOfBasicData: SectionModelType {
    typealias Item = Any

    init(original: SectionOfBasicData, items: [Item]) {
        self = original
        self.items = items
    }
}
