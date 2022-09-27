//
//  MembersResponseDTO.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/27.
//

import Foundation

struct MembersResponseDTO: Codable {
    let success: Bool
    let result: MemberInfo?
    let error: RESTError?
}
