//
//  String+.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/30.
//

import Foundation

extension String {
    var isGalleryType: GalleryType {
        switch self.lowercased() {
        case "major":
            return .major
        case "minor":
            return .minor
        case "mini":
            return .mini
        default:
            return .none
        }
    }
}
