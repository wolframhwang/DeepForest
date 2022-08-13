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
        let info = PublishRelay<Bool>()
    }
    
    init(coordinator: SignInCoordinator?, signInUseCase: SignInUseCase) {
        self.coordinator = coordinator
        self.signInUseCase = signInUseCase
    }
    
    func transform(from input: Input) -> Output {
        configureInput(input)
        return createOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configureInput(_ input: Input) {
        Observable
            .combineLatest(input.idObserverable, input.pwObservable) { id, pw in
                return AccountForSignIn(id: id, pw: pw)
            }
            .bind(to: signInUseCase.signInInfo)
            .disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        input.buttonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.signInUseCase.singIn()
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { _ in
                        self?.coordinator?.finish()
                    }, onError: { error in
                        self?.coordinator?.showAlert(error)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
