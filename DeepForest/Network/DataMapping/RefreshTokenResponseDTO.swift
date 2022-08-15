//
//  RefreshTokenResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let success: Bool
    let result: TokenResultDTO?
    let error: RESTError?
}
