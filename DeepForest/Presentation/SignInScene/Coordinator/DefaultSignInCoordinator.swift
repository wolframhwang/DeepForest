//
//  DefaultSignInCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/28.
//

import Foundation
import UIKit

class DefaultSignInCoordinator: SignInCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .signin
    var signInViewController: SignInViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signInViewController = SignInViewController()
    }
    
    func start() {
        self.navigationController.viewControllers = [self.signInViewController]
    }
    
    func pushSignInViewController() {
        self.navigationController.pushViewController(self.signInViewController, animated: true)
    }
}
