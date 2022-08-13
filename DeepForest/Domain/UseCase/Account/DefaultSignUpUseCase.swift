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
        switch userId.count {
        case 0...0:
            userIdState.onNext("5자 ~ 20자 영문, 숫자로 입력해주세요.")
        case 1...4:
            userIdState.onNext("ID가 너무 짧습니다.")
        case 5...20:
            userIdState.onNext("적절합니다!")
        default:
            userIdState.onNext("너무 길어요!")
        }
    }
    
    func validateNickName(nickName: String) {
        switch nickName.count {
        case 0...0:
            nickNameState.onNext("20자 내외로 닉네임 입력해주세요! :)")
        case 1...20:
            nickNameState.onNext("적절합니다!")
        default:
            nickNameState.onNext("너무 길어요!")
        }
    }
    
    func validatePassword(password: String, rePassword: String) {
        if password.count == 0 || rePassword.count == 0 {
            passwordState.onNext("영문, 숫자 8~20자 내외로 해주세요")
        }
        if password.count < 8 || rePassword.count < 8 {
            passwordState.onNext("문자가 너무 적어요!")
        }
        if password.count > 20 || rePassword.count > 20 {
            passwordState.onNext("문자가 너무 많아요!")
        }
        if password != rePassword { passwordState.onNext("비밀번호가 불일치합니다.")}
        let passwordreg = ("(?=.*[A-Za-z])(?=.*[0-9]).{8,20}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        
        passwordState.onNext(passwordtesting.evaluate(with: password) && passwordtesting.evaluate(with: rePassword) ? ("적당한 비밀번호입니다!") : ("영어, 숫자를 섞어주세요!"))
    }
    
    func validateEmail(email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        if emailValid.evaluate(with: email) {
            emailState.onNext("이메일이 유효합니다!")
        }
        else {
            emailState.onNext("이메일이 유효하지 않아요.")
        }        
    }
    
    
}
