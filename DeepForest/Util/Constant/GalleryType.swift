//
//  GalleryType.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

enum GalleryType: String, Codable {
    case major = "메이저 갤러리"
    case minor = "마이너 갤러리"
    case mini = "미니 갤러리"
    case none = "NONE"
    
    var galleryType: String {
        switch self {
        case .major:
            return "MAJOR"
        case .minor:
            return "MINOR"
        case .mini:
            return "MINI"
        case .none:
            return "NONE"
        }
    }
    
    func isType(_ str: String) -> GalleryType {
        if str == "MAJOR" || str == "major" {
            return .major
        } else if str == "MINOR" || str == "minor" {
            return .minor
        } else if str == "MINI" || str == "mini" {
            return .mini
        }
        return .none
    }
}
