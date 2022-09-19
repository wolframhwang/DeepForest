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
        let trigger: Driver<Void>
    }
    
    struct Output {
        
    }
    
    init(coordinator: AppStartCoordinator?, appStartUseCase: AppStartUseCase) {
        self.coordinator = coordinator
        self.appStartUseCase = appStartUseCase
    }
    
    func transforming(from input: Input,
                      disposeBag: DisposeBag) -> Output {
        input.trigger.drive(onNext: {
            self.appStartUseCase.refreshToken()
                .observe(on: MainScheduler.asyncInstance)
                .subscribe(onNext: { [weak self] isSuccess in
                    self?.coordinator?
                        .finishWithSign(with: isSuccess)
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
