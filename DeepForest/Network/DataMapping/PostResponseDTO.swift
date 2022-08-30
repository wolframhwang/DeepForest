//
//  PostResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/30.
//

import Foundation

struct PostResponseDTO: Codable {
    let success: Bool
    let result: Int?
    let error: RESTError?
}
