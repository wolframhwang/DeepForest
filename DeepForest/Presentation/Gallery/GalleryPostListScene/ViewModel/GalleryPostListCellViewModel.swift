//
//  GalleryPostListCellViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/27.
//

import Foundation

final class GalleryPostListCellViewModel {
    let postId: Int
    let writer: String
    let title: String
    let createdAt: String
    let commentCount: Int
    let likeCount: Int
    let viewCount: Int
    init(with post: GalleryPostItem) {
        postId = post.postId
        writer = post.nickName
        title = post.title
        createdAt = post.createdAt
        commentCount = post.commentCount
        likeCount = post.likeCount
        viewCount = post.viewCount
    }
}
