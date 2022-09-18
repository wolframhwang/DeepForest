//
//  Comments.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/17.
//

import Foundation

struct CommentItem: Codable {
    let commentId: Int
    let nickName: String
    let username: String
    let createdAt: String
    let content: String
    
    init(with comment: CommentInfo) {
        self.commentId = comment.id
        self.nickName = comment.writer.nickname
        self.username = comment.writer.username
        self.createdAt = comment.createdAt
        self.content = comment.content
    }
}
