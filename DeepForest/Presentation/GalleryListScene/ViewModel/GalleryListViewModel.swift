//
//  GalleryListViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa

final class GalleryListViewModel: ViewModelType {
    private weak var coordinator: GalleryListCoordinator?
    private let galleryListUseCase: GalleryListUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let galleryLists: Driver<[GalleryListCellViewModel]>
        let selectedGallery: Driver<GalleryListCellViewModel>
    }
    
    init(coordinator: GalleryListCoordinator?,
         galleryListUseCase: GalleryListUseCase) {
        self.coordinator = coordinator
        self.galleryListUseCase = galleryListUseCase
    }
    
    func transform(from input: Input) -> Output {
        let galleryList = galleryListUseCase.fetchGalleryList()
            .asDriver(onErrorJustReturn: [])
            .map {
                return $0.map { item in
                    GalleryListCellViewModel(with: item)
                }
            }
        
        let selectedGallery = input.selection.withLatestFrom(galleryList) { (indexPath, galleryList) -> GalleryListCellViewModel in
            return galleryList[indexPath.row]
        }.do(onNext: { [weak self] viewModel in
                print("SELECTED", viewModel)
            })
        
        return Output(galleryLists: galleryList,
                      selectedGallery: selectedGallery)
    }
}
