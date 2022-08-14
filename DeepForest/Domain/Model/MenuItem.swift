//
//  MenuItem.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

enum MenuType {
    case galleryList
}

struct MenuItem {
    let title: String
    let type: MenuType
}
