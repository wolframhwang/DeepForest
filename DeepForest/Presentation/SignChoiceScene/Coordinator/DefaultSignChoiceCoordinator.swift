//
//  DefaultSignChoiceCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import UIKit

final class DefaultSignChoiceCoordinator: SignChoiceCoordinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .signChoice
    var signChoiceViewController: SignChoiceViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signChoiceViewController = SignChoiceViewController()
    }
    
    func start() {
        self.navigationController.viewControllers = [self.signChoiceViewController]
    }
    
    
}
