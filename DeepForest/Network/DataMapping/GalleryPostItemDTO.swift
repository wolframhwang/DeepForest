//
//  GalleryPostItemDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/27.
//

import Foundation

struct GalleryPostItemDTO: Codable {
    let id: Int
    let nickname: String
    let title: String
    let createdAt: String
    let updatedAt: String
    let postStatistics: PostStaticsDTO
}
struct PostStaticsDTO: Codable {
    let viewCount: Int
    let likeCount: Int
    let dislikeCount: Int
    let commentCount: Int
}

struct WriterDTO: Codable {
    let nickname: String
    let username: String
}
