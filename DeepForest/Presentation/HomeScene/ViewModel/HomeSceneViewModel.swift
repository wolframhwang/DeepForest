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
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: HomeSceneCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
