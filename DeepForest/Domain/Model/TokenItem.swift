//
//  tokenItem.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

struct TokenItem: Codable {
    let token: String
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case token = "accessToken"
        case refreshToken
    }
}
