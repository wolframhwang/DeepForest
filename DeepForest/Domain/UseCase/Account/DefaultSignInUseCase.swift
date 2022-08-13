//
//  DefaultSignInUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/02.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultSignInUseCase: SignInUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    var signInInfo = BehaviorSubject<AccountForSignIn>(value: AccountForSignIn(id: "", pw: ""))

    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func singIn() -> Observable<Bool> {
        return networkRepository
    }
}
