//
//  GalleryPostListUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol GalleryPostListUseCase {
    func fetchGalleryPostList() -> Observable<[GalleryPostItem]>
    var title: Observable<String> { get }
    var galleryId: Observable<Int> { get }
}
