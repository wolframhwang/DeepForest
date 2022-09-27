//
//  UserRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/09.
//

import Foundation

protocol UserRepository {
    func saveUserInfo(userInfo: MemberInfo)
    func saveNickName(nickName: String)
    func saveToken(token: String, refreshToken: String)
    func deleteTokenInfo()
    func deleteSignInfo()
    func deleteMyInfo()
    func fetchToken() -> String?
    func fetchRefreshToken() -> String?
    func fetchNickName() -> String?
}
