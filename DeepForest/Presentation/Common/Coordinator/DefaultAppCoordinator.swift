//
//  DefaultAppCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import UIKit

final class DefaultAppCoordinator: AppCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        self.showSignChoiceFlow()
    }
    
    func showSignChoiceFlow() {
        let signChoiceCoordinator = DefaultSignChoiceCoordinator(self.navigationController)
        signChoiceCoordinator.finishDelegate = self
        signChoiceCoordinator.start()
        childCoordinators.append(signChoiceCoordinator)
    }
    
    func showMainSceneFlow() {
        // To-do: Network 구현 시 구현해야함
    }
    
    
}
