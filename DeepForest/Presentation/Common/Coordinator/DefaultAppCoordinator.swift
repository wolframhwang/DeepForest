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
        navigationController.setNavigationBarHidden(true, animated: true)
        signChoiceCoordinator.start()
        childCoordinators.append(signChoiceCoordinator)
    }
    
    func homeSceneFlow() {
        let homeSceneCoordinator = DefaultHomeSceneCoordinator(self.navigationController)
        homeSceneCoordinator.finishDelegate = self
        navigationController.setNavigationBarHidden(false, animated: true)
        homeSceneCoordinator.start()
        childCoordinators.append(homeSceneCoordinator)
    }
    
    func showMainSceneFlow() {
        // To-do: Network 구현 시 구현해야함
    }
    
    
}

extension DefaultAppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter({ coord in
            coord.type != childCoordinator.type
        })
        self.navigationController.view.backgroundColor = .systemBackground
        self.navigationController.viewControllers.removeAll()
        switch childCoordinator.type {
        case .signChoice:
            self.homeSceneFlow()
        case .home:
            self.showSignChoiceFlow()
        default:
            break
        }
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        
    }
}
