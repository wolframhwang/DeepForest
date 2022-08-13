//
//  AccountForSignUp.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation

struct AccountForSignUp: Codable {
    let userId: String
    let password: String
    let email: String
    let nickName: String
    
    private enum CodingKeys: String, CodingKey {
        case userId = "username"
        case password, email
        case nickName = "nickname"
    }
}
