//
//  DefaultSignUpUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift
let idInit = "아이디를 입력해주세요."
let nickInit = "닉네임을 입력해주세요."
let pwInit = "패스워드를 입력해 주세요."
let emailInit = "이메일을 입력해 주세요."
final class DefaultSignUpUseCase: SignUpUseCase {
    private let networkRepository: NetworkRepository
    
    var userIdState = BehaviorSubject<String>(value: idInit)
    var nickNameState = BehaviorSubject<String>(value: nickInit)
    var passwordState = BehaviorSubject<String>(value: pwInit)
    var emailState = BehaviorSubject<String>(value: emailInit)
    
    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }
    
    
    func validateUserId(userId: String) {
        
    }
    
    func validateNickName(nickName: String) {
        
    }
    
    func validatePassword(password: String, rePassword: String) {
        
    }
    
    func validateEmail(email: String) {
        
    }
    
    
}
