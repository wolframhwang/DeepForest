//
//  TokenResultDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation

struct TokenResultDTO: Codable {
    var grantType: String
    var accessToken: String
    var refreshToken: String        
}
