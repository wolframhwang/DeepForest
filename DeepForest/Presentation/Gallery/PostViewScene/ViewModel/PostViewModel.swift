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
    
    struct Input {
    }
    
    struct Output {
        let navigationTitle = BehaviorRelay<String>(value: "")
        let title = PublishRelay<String>()
        let content = PublishRelay<String>()
        let imageArrays = PublishRelay<[(image: UIImage?, number: Int)]>()
        let writer = PublishRelay<String>()
        let date = PublishRelay<String>()
        let comments = PublishRelay<[CommentItem]>()
    }
    
    init(coordinator: PostViewCoordinator?,
         postViewUseCase: PostViewUseCase) {
        self.coordinator = coordinator
        self.postViewUseCase = postViewUseCase
    }
    let title = BehaviorSubject<String>(value: "")
    
    func transform(from input: Input) -> Output {
        return Output()
    }
    
    func transformed(from input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        self.postViewUseCase.fetchPost()
            .subscribe(onNext: { [weak self] result in
                if result != nil {
                    self?.coordinator?.showAlert(AlamofireImageUploadServiceError.unknownError)
                }
            })
            .disposed(by: disposeBag)
        
        self.postViewUseCase.navigationTitleObservable
            .bind(to: output.navigationTitle)
            .disposed(by: disposeBag)
                    
        self.postViewUseCase.titleObservable
            .bind(to: output.title)
            .disposed(by: disposeBag)
        
        self.postViewUseCase.contentObservable
            .bind(to: output.content)
            .disposed(by: disposeBag)
        
        self.postViewUseCase.imageArray
            .map { imageArray -> [(image: UIImage?, number: Int)] in
                guard let imageArray = imageArray else { return [] }
                return imageArray.map { image in
                    let url = URL(string: image.url)
                    let data = try? Data(contentsOf: url!)
                    return (UIImage(data: data!), image.number)
                }
            }
            .bind(to: output.imageArrays)
            .disposed(by: disposeBag)
        
        self.postViewUseCase.writerObservable
            .bind(to: output.writer)
            .disposed(by: disposeBag)
        
        self.postViewUseCase.dateObservable
            .bind(to: output.date)
            .disposed(by: disposeBag)
        
        self.postViewUseCase.fetchComments()
            .bind(to: output.comments)
            .disposed(by: disposeBag)

        return output
    }
}
