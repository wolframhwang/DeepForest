//
//  MainSceneViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift

final class HomeSceneViewModel: ViewModelType {
    var coordinator: HomeSceneCoordinator?
    let disposeBag = DisposeBag()
    
    struct Input {
        let menuButtonTapped: Observable<Void>
    }
    
    struct Output {
        
    }
    
    init(coordinator: HomeSceneCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        configureInput(input)
        return configrueOutput(from: input, disposeBag: disposeBag)
    }
    
    private func configrueOutput(from input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
    
    private func configureInput(_ input: Input) {
        input.menuButtonTapped.subscribe(onNext: { [weak self] in
            self?.coordinator?.showMenuScene()
        })
        .disposed(by: disposeBag)
    }
}
