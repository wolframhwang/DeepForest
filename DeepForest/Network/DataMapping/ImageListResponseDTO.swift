//
//  imageListResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/05.
//

import Foundation

struct ImageListResponseDTO: Codable {
    let success: Bool
    let result: [String]?
    let error: RESTError?
}
