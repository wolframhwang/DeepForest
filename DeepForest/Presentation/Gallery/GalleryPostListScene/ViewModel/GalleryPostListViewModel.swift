//
//  GalleryPostListViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleryPostListViewModel: ViewModelType {
    private weak var coordinator: GalleryPostListCoordinator?
    private let galleryPostListUseCase: GalleryPostListUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    init(coordinator: GalleryPostListCoordinator?,
         galleryPostListUseCase: GalleryPostListUseCase) {
        self.coordinator = coordinator
        self.galleryPostListUseCase = galleryPostListUseCase
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
