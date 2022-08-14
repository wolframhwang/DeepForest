//
//  AppCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import Foundation

protocol AppCoordinator: Coordinator {
    func showSignChoiceFlow()
    func showMainSceneFlow()
    func homeSceneFlow()
}
