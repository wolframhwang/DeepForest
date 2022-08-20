//
//  DefaultSettingCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import RxSwift

final class DefaultSettingCoordinator: SettingCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var settingViewController: SettingViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .setting
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.settingViewController = SettingViewController()
    }
    
    func start() {
        
    }
    
    func pushSettingViewController() {
        // Todo: ViewModel Setting 해야 함
        self.settingViewController.viewModel = SettingViewModel(coordinator: self, settingUseCase: DefaultSettingUseCase(userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())))
        self.navigationController.pushViewController(self.settingViewController, animated: true)
    }
    
    func showSignInfoScene() {
        let signInfoCoordinator = DefaultSignInfoCoordinator(self.navigationController)
        signInfoCoordinator.finishDelegate = self
        self.childCoordinators.append(signInfoCoordinator)
        signInfoCoordinator.pushSignInfoViewController()
    }
}

extension DefaultSettingCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        
    }
}

