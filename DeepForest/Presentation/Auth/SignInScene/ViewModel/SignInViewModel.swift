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
        let backButtonTapObservable: Observable<Void>
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
        
        input.backButtonTapObservable.subscribe(onNext: { [weak self] in
            self?.coordinator?.popScene()
        })
        .disposed(by: disposeBag)
    }
    
    private func createOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        input.buttonTapObservable
            .subscribe(onNext: { [weak self] in
                self?.signInUseCase.signIn()
                    //.observe(on: MainScheduler.instance)
                    .subscribe(onNext: { failMessage in
                        if let failMessage = failMessage {
                            self?.coordinator?.showAlert(failMessage)
                        } else {
                            self?.signInUseCase.fetchMyInfo()
                                .observe(on: MainScheduler.asyncInstance)
                                .subscribe(onNext: { result in
                                    if result == nil {
                                        self?.coordinator?.finish()
                                    } else {
                                        self?.coordinator?.showAlert(result ?? "")
                                    }
                                })
                                .disposed(by: disposeBag)
                        }
                    })
                    .disposed(by: disposeBag)
            }, onError: { error in
                self.coordinator?.showAlert(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}
