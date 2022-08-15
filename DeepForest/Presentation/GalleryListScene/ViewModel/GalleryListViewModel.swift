//
//  GalleryListViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift

final class GalleryListViewModel: ViewModelType {
    private weak var coordinator: GalleryListCoordinator?
    private let disposeBag = DisposeBag()
    
    struct Input {}
    struct Output {}
    
    init(coordinator: GalleryListCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
