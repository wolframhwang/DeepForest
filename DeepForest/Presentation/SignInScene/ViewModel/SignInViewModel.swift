//
//  SignInViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/02.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel: ViewModelType {
    private weak var coordinator: SignInCoordinator?
    private let signInUseCase: SignInUseCase
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let idObserverable: Observable<String>
        let pwObservable: Observable<String>
        let buttonTapObservable: Observable<Void>
    }
    
    struct Output {
        let info = BehaviorRelay<Void>(value: Void())
    }
    
    init(coordinator: SignInCoordinator?, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.signInUseCase = signInUseCase
    }
    
    func transform(from input: Input) -> Output {
        self.configureInput(input: input, disposeBag: disposeBag)
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(input: Input, disposeBag: DisposeBag) {
        input.idObserverable
            .subscribe(onNext: { [weak self] username in
                self?.signInUseCase.validateId(text: username)
            })
            .disposed(by: disposeBag)
        
        input.pwObservable
            .subscribe(onNext: { [weak self] password in
                self?.signInUseCase.validatePw(text: password)
            })
            .disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        
        
        return output
    }
}
