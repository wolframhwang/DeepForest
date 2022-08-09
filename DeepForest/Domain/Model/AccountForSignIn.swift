//
//  AccountForSignIn.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/09.
//

import Foundation

struct AccountForSignIn: Codable {
    let id: String
    let pw: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "username"
        case pw = "password"
    }
}
