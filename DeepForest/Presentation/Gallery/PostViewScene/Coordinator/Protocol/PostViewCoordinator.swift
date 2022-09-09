//
//  PostViewCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation

protocol PostViewCoordinator: Coordinator {
    func pushPostViewScene(postId: Int)
    func showAlert(_ error: Error)
}
