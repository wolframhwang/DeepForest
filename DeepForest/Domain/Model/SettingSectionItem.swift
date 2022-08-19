//
//  SettingSectionItem.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import RxDataSources

struct SettingSectionItem<Section, ItemType> {
    public var model: Section
    public var items: [Item]
    
    init(model: Section, items: [Item]) {
        self.model = model
        self.items = items
    }
}

extension SettingSectionItem: SectionModelType {
    public typealias Identity = Section
    public typealias Item = ItemType
    
    public var identity: Section { return model }
}
