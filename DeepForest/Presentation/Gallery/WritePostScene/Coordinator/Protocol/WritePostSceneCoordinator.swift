//
//  WritePostSceneCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa

protocol WritePostSceneCoordinator: Coordinator {
    func presentWritePostScene(galleryId: Int)
    func popScene()
    func showAlert(_ error: Error)
}
