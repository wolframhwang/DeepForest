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
    
    
    init(networkRepository: NetworkRepository,
         galleryInfo: Gallery) {
        self.networkRepository = networkRepository
        self.galleryInfo = galleryInfo
    }
}
