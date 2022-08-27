//
//  DefaultGalleryPostListUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultGalleryPostListUseCase: GalleryPostListUseCase {
    private let networkRepository: NetworkRepository
    
    private let galleryInfo: Gallery
    
    var title: Observable<String>
    
    init(networkRepository: NetworkRepository,
         galleryInfo: Gallery) {
        self.networkRepository = networkRepository
        self.galleryInfo = galleryInfo
        self.title = Observable.just(galleryInfo.galleryName)
    }
    
    func fetchGalleryPostList() -> Observable<[GalleryPostItem]> {
        let galleryId = galleryInfo.galleryId
        print(galleryId)
        return networkRepository.fetch(urlSuffix: "/api/v1/posts", queryItems: ["galleryId": "\(galleryId)"]).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder()
                        .decode(GalleryPostItemsDTO.self, from: data)
                    if response.success {
                        guard let fetchResponse = response.result else {
                            return []
                        }
                        
                        return fetchResponse.map { dto -> GalleryPostItem in
                            return GalleryPostItem(postId: dto.id,
                                            nickName: dto.nickname,
                                            title: dto.title,
                                            createdAt: dto.createdAt,
                                            likeCount: dto.postStatistics.likeCount,
                                            commentCount: dto.postStatistics.commentCount
                                                   ,
                                                   viewCount: dto.postStatistics.viewCount,
                                                   
                                                   write: dto.nickname)
                        }
                    } else {
                        return []
                    }
                } catch {
                    print("DECODE ERROR")
                    return []
                }
            case .failure(let error):
                return []
            }
        }
    }
}
