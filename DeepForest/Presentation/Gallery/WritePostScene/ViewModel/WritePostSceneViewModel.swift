//
//  WritePostSceneViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa

final class WritePostSceneViewModel: ViewModelType {
    private weak var coordinator: WritePostSceneCoordinator?
    private let writePostSceneUseCase: WritePostSceneUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: WritePostSceneCoordinator?,
         writePostSceneUseCase: WritePostSceneUseCase) {
        self.coordinator = coordinator
        self.writePostSceneUseCase = writePostSceneUseCase
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
