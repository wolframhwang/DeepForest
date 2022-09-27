//
//  DefaultUserRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/09.
//

import Foundation

final class DefaultUserRepository: UserRepository {
    func saveUserInfo(userInfo: MemberInfo) {
        UserDefaults.standard.set(userInfo.nickname, forKey: UserDefaultsKey.nickname)
        UserDefaults.standard.set(userInfo.username, forKey: UserDefaultsKey.username)
        UserDefaults.standard.set(userInfo.email, forKey: UserDefaultsKey.email)
        UserDefaults.standard.set(userInfo.memberType, forKey: UserDefaultsKey.memberType)
    }
    
    func saveNickName(nickName: String) {
        UserDefaults.standard.set(nickName, forKey: UserDefaultsKey.nickname)
    }
    func saveToken(token: String, refreshToken: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKey.token)
        UserDefaults.standard.set(refreshToken, forKey: UserDefaultsKey.refreshToken)
    }
    func deleteTokenInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.token)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.refreshToken)
    }
    func deleteSignInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.token)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.refreshToken)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.nickname)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.username)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.email)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.memberType)
    }
    
    func deleteMyInfo() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.nickname)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.username)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.email)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.memberType)
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
    func fetchUserName() -> String? {
        guard let userName = UserDefaults.standard.string(forKey: UserDefaultsKey.username) else {
            return nil
        }
        return userName
    }
    func fetchEmail() -> String? {
        guard let email = UserDefaults.standard.string(forKey: UserDefaultsKey.email) else {
            return nil
        }
        return email
    }
    
    func fetchMemType() -> String? {
        guard let memType = UserDefaults.standard.string(forKey: UserDefaultsKey.memberType) else {
            return nil
        }
        return memType
    }
}
