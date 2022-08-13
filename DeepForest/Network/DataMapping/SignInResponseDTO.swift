//
//  SignInResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation

struct SignInResponseDTO: Codable {
    let success: Bool
    let result: TokenResultDTO?
    let error: RESTError?
}
