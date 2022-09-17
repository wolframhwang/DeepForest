//
//  DefaultPostViewUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultPostViewUseCase: PostViewUseCase {

    
    private let postId: Int
    private let networkRepository: NetworkRepository
    private let userRepository: UserRepository
    
    var navigationTitleObservable = BehaviorSubject<String>(value: "DeepForest")
    var titleObservable = BehaviorSubject<String>(value: "")
    var contentObservable = PublishSubject<String>()
    var writerObservable = PublishSubject<String>()
    var dateObservable = PublishSubject<String>()
    
    var imageArray = PublishSubject<[ImageArrayResponseDTO]?>()
    
    init(postId: Int,
         userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.postId = postId
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func fetchPost() -> Observable<String?> {
        return networkRepository.fetch(urlSuffix: "/api/v1/posts/\(postId)", queryItems: nil).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(SinglePostResponseDTO.self, from: data)
                    if response.success {
                        guard let res = response.result else { return URLSessionNetworkServiceError.unknownError.localizedDescription }
                        
                        self?.titleObservable.onNext(res.title)
                        self?.contentObservable.onNext(res.content)
                        self?.imageArray.onNext(res.images)
                        self?.writerObservable.onNext(res.nickname)
                        self?.dateObservable.onNext(res.createdAt)

                        return nil
                    } else {
                        return response.error?.message
                    }
                }
            case .failure(let error):
                return error.localizedDescription
            }
        }
    }
    
    func fetchComments() -> Observable<[CommentItem]> {
        return networkRepository.fetch(urlSuffix: "/api/v1/posts/\(postId)/comments", queryItems: nil).map { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(CommentsResponseDTO.self, from: data)
                    if response.success {
                        guard let res = response.result else { return [] }
                        return res.map { CommentItem(with: $0) }
                    } else { return [] }
                } catch {
                    return []
                }
            case .failure(let error):
                return []
            }
        }
    }
}
