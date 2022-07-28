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
    var coordinator: SignChoiceCoordinator?
    let disposeBag = DisposeBag()
    
    struct Input {
        let signInButtonDidTapEvent: Observable<Void>
        let signUpButtonDidTapEvent: Observable<Void>
        let noSignJoinButtonDidTapEvent: Observable<Void>
    }
    
    struct Output {
        
    }
    init(coordinator: SignChoiceCoordinator?) {
        self.coordinator = coordinator
    }
    
    @discardableResult
    func transform(from input: Input) -> Output {
        let output =  Output()
        print("TRANSFORM")
        input.signInButtonDidTapEvent
            .subscribe(onNext: { [weak self] _ in
                print("Tapped")
                self?.coordinator?.showSignInFlow()
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
