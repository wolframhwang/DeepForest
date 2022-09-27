//
//  AppStartViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class AppStartViewModel: ViewModelType {
    private weak var coordinator: AppStartCoordinator?
    private let appStartUseCase: AppStartUseCase
    
    struct Input {
        let trigger: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(coordinator: AppStartCoordinator?, appStartUseCase: AppStartUseCase) {
        self.coordinator = coordinator
        self.appStartUseCase = appStartUseCase
    }
    
    func transforming(from input: Input,
                      disposeBag: DisposeBag) -> Output {
        input.trigger.subscribe(onNext: { [weak self] in
            self?.appStartUseCase.refreshToken()
                .subscribe(onNext: { isSuccess in
                    self?.appStartUseCase.fetchMyInfo()
                        .observe(on: MainScheduler.asyncInstance)
                        .subscribe(onNext: { result in
                            if result == nil {
                                self?.coordinator?
                                    .finishWithSign(with: isSuccess)
                            } else {
                                self?.coordinator?.finishWithSign(with: false)
                            }
                        }, onError: { error in
                            self?.coordinator?.finishWithSign(with: false)
                        })
                        .disposed(by: disposeBag)
                }, onError: { [weak self] error in
                    self?.coordinator?
                        .finishWithSign(with: false)
                })
                .disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
        
        return Output()
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
