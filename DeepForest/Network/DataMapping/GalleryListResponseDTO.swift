//
//  GalleryListResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

struct GalleryListResponseItemDTO: Codable {
    let id: Int
    let type: String
    let name: String
}

struct GalleryListResponseDTO: Codable {
    let success: Bool
    let result: [GalleryListResponseItemDTO]?
    let error: RESTError?
}
