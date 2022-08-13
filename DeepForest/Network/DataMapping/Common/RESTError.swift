//
//  RESTError.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation

struct RESTError: Codable {
    let message: String
    let code: String
}
