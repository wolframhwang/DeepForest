//
//  DefaultWritePostSceneUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxCocoa
import RxSwift

enum PostFail: Error {
    case titleNil
    case contentNil
    case emptyError
    case tokenFetchError
}

final class DefaultWritePostSceneUseCase: WritePostSceneUseCase {
    private let disposeBag = DisposeBag()
    private let galleryId: Int
    private let networkRepository: NetworkRepository
    private let userRepository: UserRepository
    
    var titleObservable = BehaviorSubject<String>(value: "글쓰기")
    var title = BehaviorSubject<String?>(value: nil)
    var content = BehaviorSubject<String?>(value: nil)
    
    init(galleryId: Int, userRepository: UserRepository, networkRepository: NetworkRepository) {
        self.galleryId = galleryId
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func refreshToken() -> Observable<Bool> {
        guard let token = userRepository.fetchToken() else {
            return Observable.error(AuthFail.noData)
        }
        guard let refreshToken = userRepository.fetchRefreshToken() else {
            return Observable.error(AuthFail.noData)
        }
        let tokenItem = TokenItem(token: token, refreshToken: refreshToken)

        userRepository.deleteTokenInfo()
        return networkRepository.post(tokenItem: tokenItem).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
                    if response.success {
                        guard let refreshTokenResponse = response.result else {
                            return false
                        }
                        self?.userRepository.saveToken(token: refreshTokenResponse.accessToken,
                                                 refreshToken: refreshTokenResponse.refreshToken)
                        return true
                    } else {
                        return false
                    }
                } catch {
                    return false
                }
            case .failure(let error):
                return false
            }
        }
    }
    
    func postingMyContent() -> Observable<String?> {
        guard let title = try? title.value() else {
            return Observable.error(PostFail.titleNil)
        }
        guard let content = try? content.value() else {
            return Observable.error(PostFail.contentNil)
        }
        if title.count == 0 || content.count == 0 {
            return Observable.error(PostFail.emptyError)
        }
        let item = ContentItem(galleryId: galleryId,
                               title: title,
                               content: content)
        guard let token = userRepository.fetchToken() else {
            return Observable.error(PostFail.tokenFetchError)
        }
        return networkRepository.postWithToken(item: item,
                                               to: "/api/v1/posts",
                                               token: token)
        .map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(PostResponseDTO.self, from: data)
                    if response.success {
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
    
}
