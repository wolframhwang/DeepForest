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
        self.signChoiceViewController.viewModel = SignChoiceViewModel(coordinator: self,
                                                                      signChoiceUseCase: DefaultSignChoiceUseCase(userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())
                                                                                                                 )
        )
        self.navigationController.viewControllers = [self.signChoiceViewController]
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func showSignInFlow() {
        let signInCoordinator = DefaultSignInCoordinator(self.navigationController)
        signInCoordinator.finishDelegate = self
        self.childCoordinators.append(signInCoordinator)
        signInCoordinator.pushSignInViewController()
    }
    
    func showSignUpFlow() {
        let signUpCoordinator = DefaultSignUpCoordinator(self.navigationController)
        signUpCoordinator.finishDelegate = self
        self.childCoordinators.append(signUpCoordinator)
        signUpCoordinator.pushSignUpViewController()
    }
    
    func joinNoSignInFlow() {
        
    }
}

extension DefaultSignChoiceCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        navigationController.popViewController(animated: true)
        self.childCoordinators.removeLast()        
    }
}
