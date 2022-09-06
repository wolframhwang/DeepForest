//
//  ContentItemSignIn.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/30.
//

import Foundation

struct ContentImages: Codable {
    let number: Int
    let url: String
}

struct ContentItem: Codable {
    let galleryId: Int
    let title: String
    let content: String
    let images: [ContentImages]?
}
