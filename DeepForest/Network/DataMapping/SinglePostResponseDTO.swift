//
//  SinglePostResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation

struct SinglePostResponseDTO: Codable {
    let success: Bool
    let result: PostInfo?
    let error: RESTError?
}

struct PostInfo: Codable {
    let id: Int
    let nickname: String
    let title: String
    let createdAt: String
    let updatedAt: String
    let postStatistics: PostStaticsDTO
    let content: String
    let images: [ImageArrayResponseDTO]?
}

struct ImageArrayResponseDTO: Codable {
    let number: Int
    let url: String
}
