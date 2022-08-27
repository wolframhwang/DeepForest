//
//  GalleryPostItemDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/27.
//

import Foundation

struct GalleryPostItemsDTO: Codable {
    let success: Bool
    let result: [GalleryPostItemDTO]?
    let error: RESTError?
}
/*
 {
 "success":true,
 "result":[
 {
 "id":81,
 "nickname":"Monotone",
 "title":"맹목적인 힘!",
 "createdAt":"2022-05-21 15:29:11",
 "updatedAt":"2022-05-21 15:29:11",
 "postStatistics":{
 "viewCount":0,
 "likeCount":0,
 "dislikeCount":0,
 "commentCount":0
 
},"writer":{"memberType":"FIXED","nickname":"Monotone","username":"Monotonic"},"content":null},{"id":79,"nickname":"Wolfram","title":"글쓰기 테스트임","createdAt":"2022-05-13 13:07:16","updatedAt":"2022-05-13 13:07:16","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":75,"nickname":"Wolfram","title":"string","createdAt":"2022-04-28 13:04:05","updatedAt":"2022-05-22 12:05:22","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":74,"nickname":"Wolfram","title":"string","createdAt":"2022-04-28 13:03:59","updatedAt":"2022-04-28 13:03:59","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":73,"nickname":"Wolfram","title":"SSSS","createdAt":"2022-04-28 13:02:43","updatedAt":"2022-04-28 13:02:43","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":72,"nickname":"Wolfram","title":"SSSS","createdAt":"2022-04-28 13:02:43","updatedAt":"2022-04-28 13:02:43","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":71,"nickname":"Wolfram","title":"SSSS","createdAt":"2022-04-28 13:02:40","updatedAt":"2022-04-28 13:02:40","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"ADMIN","nickname":"Wolfram","username":"Hzw94"},"content":null},{"id":70,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:27","updatedAt":"2022-04-28 12:58:27","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":69,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:26","updatedAt":"2022-04-28 12:58:26","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":68,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:26","updatedAt":"2022-04-28 12:58:26","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":67,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:26","updatedAt":"2022-04-28 12:58:26","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":66,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:25","updatedAt":"2022-04-28 12:58:25","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":65,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:25","updatedAt":"2022-04-28 12:58:25","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":64,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:24","updatedAt":"2022-04-28 12:58:24","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":63,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:24","updatedAt":"2022-04-28 12:58:24","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":62,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:23","updatedAt":"2022-04-28 12:58:23","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":61,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:23","updatedAt":"2022-04-28 12:58:23","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":60,"nickname":"strinasdasdasdg","title":"TESTDEATH","createdAt":"2022-04-28 12:58:18","updatedAt":"2022-04-28 12:58:18","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"strinasdasdasdg","username":null},"content":null},{"id":59,"nickname":"DPDPDP","title":"DPDP","createdAt":"2022-04-27 15:15:02","updatedAt":"2022-04-27 15:15:02","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"DPDPDP","username":null},"content":null},{"id":58,"nickname":"DPDPDP","title":"DPDP","createdAt":"2022-04-27 15:15:02","updatedAt":"2022-04-27 15:15:02","postStatistics":{"viewCount":0,"likeCount":0,"dislikeCount":0,"commentCount":0},"writer":{"memberType":"NONE","nickname":"DPDPDP","username":null},"content":null}],"error":null}
 */
