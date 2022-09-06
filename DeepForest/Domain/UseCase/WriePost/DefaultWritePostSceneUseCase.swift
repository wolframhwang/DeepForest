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
    var content = BehaviorSubject<NSAttributedString?>(value: nil)
    
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
        if title.count == 0 || content.length == 0 {
            return Observable.error(PostFail.emptyError)
        }
        
        let item = ContentItem(galleryId: galleryId,
                               title: title,
                               content: content.string,
                               images: nil)
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
    
    func imageToDataArray(_ attrStr: NSAttributedString) -> [Data] {
        var images = [Data]()
        attrStr.enumerateAttribute(.attachment, in: NSRange(location: 0, length: attrStr.length)) { (value, range, stop) -> Void in
            if value is NSTextAttachment {
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                var image: UIImage? = nil
                if ((attachment?.image) != nil) {
                    image = attachment?.image
                } else {
                    image = attachment?.image(forBounds: (attachment?.bounds)!, textContainer: nil, characterIndex: range.location)
                }

                if image != nil {
                    if let data = image?.jpegData(compressionQuality: 0.9) {
                        images.append(data)
                    }
                }
            }
        }
        return images
    }
    
    func makeIndexWithImage(_ attrStr: NSAttributedString, _ imageURL: [String]?) -> [ContentImages]? {
        var images = [ContentImages]()
        var indexs = [Int]()
        guard let imageURL = imageURL else {
            return nil
        }

        attrStr.enumerateAttribute(.attachment, in: NSRange(location: 0, length: attrStr.length)) { (value, range, stop) -> Void in
            if value is NSTextAttachment {
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                var image: UIImage? = nil
                if ((attachment?.image) != nil) {
                    image = attachment?.image
                } else {
                    image = attachment?.image(forBounds: (attachment?.bounds)!, textContainer: nil, characterIndex: range.location)
                }

                if image != nil {
                    indexs.append(range.location)
                }
            }
        }
        let limit = min(indexs.count, imageURL.count)
        for i in 0..<limit {
            images.append(ContentImages(number: indexs[i], url: imageURL[i]))
        }
        
        return images
    }
    
    func postingMyContentWithImages() -> Observable<Result<Data?, AlamofireImageUploadServiceError>> {
        guard let title = try? title.value() else {
            return Observable.error(PostFail.titleNil)
        }
        guard let content = try? content.value() else {
            return Observable.error(PostFail.contentNil)
        }
        if title.count == 0 || content.length == 0 {
            return Observable.error(PostFail.emptyError)
        }
        
        let imageArray = imageToDataArray(content)
        if imageArray.isEmpty {
            return Observable.create { observe in
                observe.onNext(.success(nil))
                observe.onCompleted()
                
                return Disposables.create()
            }
        }
        
        let item = ImageItems(images: imageArray)
        
        guard let token = userRepository.fetchToken() else {
            return Observable.error(PostFail.tokenFetchError)
        }
        
        return networkRepository.postWithImage(item: item, to: "/api/v1/images/MEMBER", token: token)
    }
    
    func postingContent(imageURL: [String]?) -> Observable<String?> {
        guard let title = try? title.value() else {
            return Observable.error(PostFail.titleNil)
        }
        guard let content = try? content.value() else {
            return Observable.error(PostFail.contentNil)
        }
        if title.count == 0 || content.length == 0 {
            return Observable.error(PostFail.emptyError)
        }
        
        let item = ContentItem(galleryId: galleryId,
                               title: title,
                               content: content.string,
                               images: self.makeIndexWithImage(content, imageURL))
        
        
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
