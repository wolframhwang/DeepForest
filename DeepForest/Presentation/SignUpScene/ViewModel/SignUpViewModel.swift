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
        let submitButtnTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(coordinator: SignUpCoordinator?,
         signUpUseCase: SignUpUseCase) {
        self.coordinator = coordinator
        self.signUpUseCase = signUpUseCase
    }
    
    func transform(from input: Input) -> Output {
        return Output()
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
    }
}
