//
//  SignUpUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift


protocol SignUpUseCase {
    var userIdState: BehaviorSubject<String> { get }
    var nickNameState: BehaviorSubject<String> { get }
    var passwordState: BehaviorSubject<String> { get }
    var emailState: BehaviorSubject<String> { get }
    
    var signUpInfo: BehaviorSubject<AccountForSignUp> { get }

    func validateUserId(userId: String)
    func validateNickName(nickName: String)
    func validatePassword(password: String, rePassword: String)
    func validateEmail(email: String)
    
    func signUp() -> Observable<String?>
}
