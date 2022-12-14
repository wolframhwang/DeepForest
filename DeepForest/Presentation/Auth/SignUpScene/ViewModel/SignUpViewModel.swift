//
//  SignUpViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: ViewModelType {
    private weak var coordinator: SignUpCoordinator?
    private let signUpUseCase: SignUpUseCase
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let idTextFieldDidEditEvent: Observable<String>
        let nickNameTextFieldDidEditEvent: Observable<String>
        let pwTextFieldDidEditEvent: Observable<String>
        let repwTextFieldDidEditEvent: Observable<String>
        let emailTextFieldDidEditEvent: Observable<String>
        let submitButtonTapped: Observable<Void>
        let backButtonTapped: Observable<Void>
    }
    
    struct Output {
        var userIdConstraintLabel = BehaviorRelay<String>(value: idInit)
        var nickNameConstraintLabel = BehaviorRelay<String>(value: nickInit)
        var passwordConstraintLabel = BehaviorRelay<String>(value: pwInit)
        var emailConstraintLabel = BehaviorRelay<String>(value: emailInit)
    }
    
    init(coordinator: SignUpCoordinator?,
         signUpUseCase: SignUpUseCase) {
        self.coordinator = coordinator
        self.signUpUseCase = signUpUseCase
    }
    
    func transform(from input: Input) -> Output {
        configureInput(input)
        return configureOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        signUpUseCase.userIdState
            .bind(to: output.userIdConstraintLabel)
            .disposed(by: disposeBag)
        
        signUpUseCase.nickNameState
            .bind(to: output.nickNameConstraintLabel)
            .disposed(by: disposeBag)
        
        signUpUseCase.passwordState
            .bind(to: output.passwordConstraintLabel)
            .disposed(by: disposeBag)
        
        signUpUseCase.emailState
            .bind(to: output.emailConstraintLabel)
            .disposed(by: disposeBag)
        
        input.submitButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.signUpUseCase.signUp()
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        guard let response = response else {
                            self?.coordinator?.popScene()
                            return
                        }
                        self?.coordinator?.showAlert(response)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        return output
    }
    
    private func configureInput(_ input: Input) {
        input.idTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] userId in
                self?.signUpUseCase.validateUserId(userId: userId)
            })
            .disposed(by: disposeBag)
        
        input.nickNameTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] nickName in
                self?.signUpUseCase.validateNickName(nickName: nickName)
            })
            .disposed(by: disposeBag)
        
        input.emailTextFieldDidEditEvent
            .subscribe(onNext: { [weak self] email in
                self?.signUpUseCase.validateEmail(email: email)
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.pwTextFieldDidEditEvent, input.repwTextFieldDidEditEvent).subscribe(onNext: { [weak self] password, rePassword in
            self?.signUpUseCase.validatePassword(password: password, rePassword: rePassword)
        })
        .disposed(by: disposeBag)
        
        Observable.combineLatest(input.idTextFieldDidEditEvent,
                                 input.pwTextFieldDidEditEvent,
                                 input.emailTextFieldDidEditEvent,
                                 input.nickNameTextFieldDidEditEvent)
        .map({ id, pw, email, nickname in
            AccountForSignUp(userId: id,
                             password: pw,
                             email: email,
                             nickName: nickname)
        })
        .bind(to: signUpUseCase.signUpInfo)
        .disposed(by: disposeBag)
        
        input.backButtonTapped.subscribe(onNext: { [weak self] in
            self?.coordinator?.popScene()
        })
        .disposed(by: disposeBag)
    }
}
