//
//  DefaultWritePostSceneUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultWritePostSceneUseCase: WritePostSceneUseCase {
    private let disposeBag = DisposeBag()
    
    private let galleryType: GalleryType
    
    init(gallerType: GalleryType) {
        self.galleryType = gallerType
    }
}
