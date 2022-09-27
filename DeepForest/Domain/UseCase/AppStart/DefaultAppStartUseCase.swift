//
//  DefaultAppStartUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultAppStartUseCase: AppStartUseCase {
    private let networkRepository: NetworkRepository
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func fetchMyInfo() -> Observable<String?> {
        guard let token = userRepository.fetchToken() else {
            return Observable.error(AuthFail.noData)
        }
        userRepository.deleteMyInfo()
        return networkRepository.fetch(urlSuffix: "/api/v1/members/me", queryItems: nil, token: token).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(MembersResponseDTO.self, from: data)
                    if response.success {
                        guard let res = response.result else {
                            return response.error?.message ?? ""
                        }
                        self?.userRepository.saveUserInfo(userInfo: res)
                        return nil
                    } else {
                        return response.error?.message
                    }
                }
            case .failure(let error):
                return error.localizedDescription
            }
            
        }
    }
    
    func refreshToken() -> Observable<Bool> {
        guard let token = userRepository.fetchToken() else {
            return Observable.error(AuthFail.noData)
        }
        guard let refreshToken = userRepository.fetchRefreshToken() else {
            return Observable.error(AuthFail.noData)
        }
        let tokenItem = TokenItem(token: token, refreshToken: refreshToken)

        userRepository.deleteTokenInfo()
        return networkRepository.post(tokenItem: tokenItem).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
                    if response.success {
                        guard let refreshTokenResponse = response.result else {
                            return false
                        }
                        self?.userRepository.saveToken(token: refreshTokenResponse.accessToken,
                                                       refreshToken: refreshTokenResponse.refreshToken)
                        return true
                    } else {
                        return false
                    }
                } catch {
                    return false
                }
            case .failure(let error):
                return false
            }
        }
    }
}
