//
//  SignChoiceViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/27.
//

import Foundation
import RxSwift
import RxCocoa

final class SignChoiceViewModel: ViewModelType {
    private weak var coordinator: SignChoiceCoordinator?
    private let signChoiceUseCase: SignChoiceUseCase
    
    struct Input {
        let signInButtonDidTapEvent: Observable<Void>
        let signUpButtonDidTapEvent: Observable<Void>
        let noSignJoinButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(coordinator: SignChoiceCoordinator?, signChoiceUseCase: SignChoiceUseCase) {
        self.coordinator = coordinator
        self.signChoiceUseCase = signChoiceUseCase
    }
    
    func transforming(from input: Input, disposeBag: DisposeBag) -> Output {
        let output =  Output()
        
        input.signInButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.showSignInFlow()
            })
            .disposed(by: disposeBag)
        
        input.signUpButtonDidTapEvent
            .subscribe(onNext: {[weak self] _ in
                self?.coordinator?.showSignUpFlow()
            })
            .disposed(by: disposeBag)
        return output
    }
    
    @discardableResult
    func transform(from input: Input) -> Output {
        let disposeBag = DisposeBag()
        let output =  Output()
                
        return output
    }
}
