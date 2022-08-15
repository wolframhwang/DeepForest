//
//  DefaultUserRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/09.
//

import Foundation

final class DefaultUserRepository: UserRepository {
    func saveNickName(nickName: String) {
        UserDefaults.standard.set(nickName, forKey: UserDefaultsKey.nickname)
    }
    func saveToken(token: String, refreshToken: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKey.token)
        UserDefaults.standard.set(refreshToken, forKey: UserDefaultsKey.refreshToken)
    }
    func deleteSignInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.token)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.refreshToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.nickname)
    }
    func fetchToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: UserDefaultsKey.token) else {
            return nil
        }
        return token
    }
    func fetchRefreshToken() -> String? {
        guard let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsKey.refreshToken) else {
            return nil
        }
        return refreshToken
    }
    func fetchNickName() -> String? {
        guard let nickName = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname) else {
            return nil
        }
        return nickName
    }
}
