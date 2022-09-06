//
//  PostViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import RxSwift
import RxCocoa

final class PostViewModel: ViewModelType {
    private weak var coordinator: PostViewCoordinator?
    private let postViewUseCase: PostViewUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: PostViewCoordinator?,
         postViewUseCase: PostViewUseCase) {
        self.coordinator = coordinator
        self.postViewUseCase = postViewUseCase
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
