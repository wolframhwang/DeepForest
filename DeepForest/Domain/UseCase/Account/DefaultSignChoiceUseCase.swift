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
    
    func refreshToken() -> Observable<String?> {
        guard let tokenItem = try? tokenInfo.value() else {
            return Observable.error(AuthFail.noData)
        }
        
        return networkRepository.post(tokenItem: tokenItem).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SignInResponseDTO.self, from: data)
                    if response.success {
                        guard let signInResponse = response.result else {
                            return "로그인에 실패했습니다!"
                        }
                        self?.userRepository.saveToken(token: signInResponse.accessToken,
                                                 refreshToken: signInResponse.refreshToken)
                        self?.userRepository.saveNickName(nickName: signIn.id)
                        return nil
                    } else {
                        return ("로그인에 실패했습니다!")
                    }
                } catch {
                    return AuthFail.decodeFail.localizedDescription
                }
            case .failure(let error):
                return error.localizedDescription
            }
        }
    }
}
