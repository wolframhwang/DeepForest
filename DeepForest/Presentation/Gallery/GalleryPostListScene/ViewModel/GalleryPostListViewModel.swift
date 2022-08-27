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
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let postLists: Driver<[GalleryPostListCellViewModel]>
        let selectedPost: Driver<Post>
        let title: Driver<String>
    }
    
    init(coordinator: GalleryPostListCoordinator?,
         galleryPostListUseCase: GalleryPostListUseCase) {
        self.coordinator = coordinator
        self.galleryPostListUseCase = galleryPostListUseCase
    }
    
    func transform(from input: Input) -> Output {
        let postLists = galleryPostListUseCase.fetchGalleryPostList().asDriver(onErrorJustReturn: [])
            .map { posts in
                return posts.map { item in
                    GalleryPostListCellViewModel(with: item)
                }
            }
        let title = galleryPostListUseCase.title.asDriver(onErrorJustReturn: "")
        
        let selectedPost = input.selection.withLatestFrom(postLists) { (indexPath, posts) -> GalleryPostListCellViewModel in
            return posts[indexPath.row]
        }.map { model -> Post in
            Post(viewModel: model)
        }
        .do(onNext: {[weak self] post in
            post
        })
        
        return Output(postLists: postLists,
                      selectedPost: selectedPost,
                      title: title)
    }
}
