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
    
    init(userRepository: UserRepository, networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
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
/*
 TokenItem(token: "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiYXV0aCI6IlJPTEVfQURNSU4iLCJleHAiOjE2NjA1Mzg3ODd9.OcuAtEoRt7wLfcU5QczLHnnjATvioy9TWDGGVORwA2mf-EjN4cyRCsHPRGtnh8EM8bKPSu7K7opqP1bQQVFmbg", refreshToken: "eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE2NjExNDE3ODd9.J19nRMf10ZeY34fkEsoznfDihu2dSK3qAzn05W1eva6dd3fRWodFDjDTrOYUFz25YGB4Z6WAeXlCCzA_4QsLBA")
 */
