//
//  DefaultSignUpCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import UIKit

final class DefaultSignUpCoordinator: SignUpCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var signUpViewController: SignUpViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .signup
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signUpViewController = SignUpViewController()
    }
    
    func start() {
        
    }
    
    func pushSignUpViewController() {
        signUpViewController.viewModel = SignUpViewModel(coordinator: self,
                                                              signUpUseCase: DefaultSignUpUseCase(networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService()
                                                                )
                                                            )
                                                )
        
        self.navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
