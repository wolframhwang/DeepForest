//
//  SignUpResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let success: Bool
    let error: RESTError?
}

struct CommentResponseDTO: Codable {
    let success: Bool
    let error: RESTError?
}
