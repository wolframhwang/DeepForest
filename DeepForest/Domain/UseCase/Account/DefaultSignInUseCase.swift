//
//  DefaultSignInUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/02.
//

import Foundation
import RxSwift
import RxCocoa

enum AuthFail: Error {
    case noData
    case signInFailure
    case decodeFail
}

extension AuthFail: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "데이터가 없음"
        case .signInFailure:
            return "원인 불명 로그인 실패"
        case .decodeFail:
            return "디코딩 실패"
        }
    }
}

final class DefaultSignInUseCase: SignInUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    var signInInfo = BehaviorSubject<AccountForSignIn>(value: AccountForSignIn(id: "", pw: ""))

    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func fetchInfo() -> Observable<String?> {
        guard let signInfo = try? signInInfo.value() else {
            return Observable.error(AuthFail.noData)
        }
        let username = signInfo.id
        userRepository.deleteMyInfo()
        return networkRepository.fetch(urlSuffix: "/api/v1/members/\(username)", queryItems: nil).map { [weak self] result in
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
    
    func signIn() -> Observable<String?> {
        guard let signIn = try? signInInfo.value() else {
            return Observable.error(AuthFail.noData)
        }

        return networkRepository.post(accountInfo: signIn).map { [weak self] result in
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
