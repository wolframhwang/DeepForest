//
//  DefaultSignInUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/02.
//

import Foundation
import RxSwift
import RxCocoa

enum SignInFail: Error {
    case noData
    case signInFailure
    case decodeFail
}

extension SignInFail: LocalizedError {
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
    
    func signIn() -> Observable<String?> {
        guard let signIn = try? signInInfo.value() else {
            return Observable.error(SignInFail.noData)
        }
        print(signIn)
        return networkRepository.post(accountInfo: signIn).map { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SignInResponseDTO.self, from: data)
                    if response.success {
                        return nil
                    } else {
                        return ("로그인에 실패했습니다!")
                    }
                } catch {
                    return SignInFail.decodeFail.localizedDescription
                }
            case .failure(let error):
                return error.localizedDescription
            }
        }
    }
}
