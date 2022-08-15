//
//  GalleryListTableViewCell.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

final class GalleryListCellViewModel {
    let id: Int
    let name: String
    let type: GalleryType
    init(with gallery: Gallery) {
        self.id = gallery.galleryId
        self.name = gallery.galleryName
        self.type = gallery.type
    }
}
