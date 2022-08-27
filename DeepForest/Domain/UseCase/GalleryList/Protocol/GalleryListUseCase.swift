//
//  GalleryListUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift

protocol GalleryListUseCase {
    func fetchGalleryList() -> Observable<[Gallery]>
    var title: Observable<String> { get }
}
