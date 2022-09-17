//
//  Comments.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/17.
//

import Foundation

struct CommentsResponseDTO: Codable {
    let success: Bool
    let result: [CommentInfo]?
    let error: RESTError?
}

struct CommentInfo: Codable {
    let id: Int
    let content: String
    let createdAt: String
    let writer: WriterDTO
}
