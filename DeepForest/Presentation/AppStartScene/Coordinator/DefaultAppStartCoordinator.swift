//
//  DefaultAppStartCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultAppStartCoordinator: AppStartCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .app
    var appStartViewController: AppStartViewController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.appStartViewController = AppStartViewController()
    }
    
    func start() {
        self.appStartViewController.viewModel = AppStartViewModel(coordinator: self, appStartUseCase: DefaultAppStartUseCase(userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())))
        self.navigationController
            .pushViewController(appStartViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?
            .coordinatorDidFinish(childCoordinator: self)
    }
    
    func finishWithSign(with success: Bool) {
        self.finishDelegate?
            .finishSign(childCoordinator: self, with: success)
    }
    
}

extension DefaultAppStartCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        navigationController.popViewController(animated: true)
        self.childCoordinators.removeLast()
    }
    
    func finishSign(childCoordinator: Coordinator, with success: Bool) {
        
    }
}
