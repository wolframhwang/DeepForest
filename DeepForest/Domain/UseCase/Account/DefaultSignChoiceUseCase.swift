//
//  DefaultSignChoiceUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultSignChoiceUseCase: SignChoiceUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    var tokenInfo = BehaviorSubject<TokenItem?>(value: nil)
    
    init(userRepository: UserRepository, networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func refreshToken() -> Observable<Bool> {
        guard let tokenItem = try? tokenInfo.value() else {
            return Observable.error(AuthFail.noData)
        }
        
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
