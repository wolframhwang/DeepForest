//
//  DefaultMainSceneCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift

final class DefaultHomeSceneCoordinator: HomeSceneCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var homeSceneViewController: HomeSceneViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .home
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.homeSceneViewController = HomeSceneViewController()
    }
    
    func start() {
        let homeSceneCoordinator = DefaultHomeSceneCoordinator(self.navigationController)
        HomeSceneViewModel = HomeSceneViewModel(coordinator: self)
        homeSceneCoordinator.finishDelegate = self
        self.childCoordinators.append(homeSceneCoordinator)
    }
    
}

extension DefaultHomeSceneCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
