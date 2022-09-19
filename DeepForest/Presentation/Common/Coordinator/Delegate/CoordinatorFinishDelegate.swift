//
//  CoordinatorFinishDelegate.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/25.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
    func popChildScene(childCoordinator: Coordinator)
    func finishSign(childCoordinator: Coordinator, with success: Bool)
}
