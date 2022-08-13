//
//  UserRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/09.
//

import Foundation

protocol UserRepository {
    func saveSignInInfo()
    func deleteUserInfo()
    func fetchToken() -> String?
    func fetchNickName() -> String?
    func fetchUserInfo()
}
