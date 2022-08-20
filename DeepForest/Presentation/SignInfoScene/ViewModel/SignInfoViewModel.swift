//
//  SignInfoViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInfoViewModel: ViewModelType {
    private weak var coordinator: SignInfoCooridnator?
    private let signInfoUseCase: SignInfoUseCase
        
    struct Input {
        let tapSignOffbutton: Observable<Void>
    }
    
    struct Output {
        let idText: Driver<String>
        let titleContent: Driver<String>
    }
    
    init(coordinator: SignInfoCooridnator?,
         signInfoUseCase: SignInfoUseCase) {
        self.coordinator = coordinator
        self.signInfoUseCase = signInfoUseCase
    }
    
    func transform(from input: Input) -> Output {
        let disposeBag = DisposeBag()
        input.tapSignOffbutton.subscribe(onNext: { [weak self] in
            self?.signInfoUseCase.signOff()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: {
                self?.coordinator?.finish()
            })
            .disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
        
        return Output(idText: signInfoUseCase.idInfo.asDriver(),
                      titleContent: signInfoUseCase.titleInfo.asDriver())
    }
}
