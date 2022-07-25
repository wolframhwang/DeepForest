//
//  CoordinatorFinishDelegate.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/25.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
