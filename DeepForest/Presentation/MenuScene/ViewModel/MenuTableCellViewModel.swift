//
//  MenuTableCellViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

final class MenuTableCellViewModel {
    let title: String
    let type: MenuType
    init(with menuItem: MenuItem) {
        self.title = menuItem.title
        self.type = menuItem.type
    }
}
