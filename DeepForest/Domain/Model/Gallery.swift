//
//  GalleryType.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

struct Gallery: Codable {
    let galleryId: Int
    let galleryName: String
    let type: GalleryType
    init(viewModel: GalleryListCellViewModel) {
        galleryId = viewModel.id
        galleryName = viewModel.name
        type = viewModel.type
    }
    init(galleryId: Int, galleryName: String, type: GalleryType) {
        self.galleryId = galleryId
        self.galleryName = galleryName
        self.type = type
    }
}
