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
    
    func removeBackButtonTitle() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self.homeSceneViewController, action: nil)
        self.homeSceneViewController.navigationItem.backBarButtonItem = backButtonItem
    }
    
    func start() {
        let homeSceneCoordinator = DefaultHomeSceneCoordinator(self.navigationController)
        homeSceneViewController.viewModel = HomeSceneViewModel(coordinator: self)
        homeSceneCoordinator.finishDelegate = self
        self.childCoordinators.append(homeSceneCoordinator)
        self.navigationController.pushViewController(homeSceneViewController, animated: true)
        self.removeBackButtonTitle()
    }
    
    func showMenuScene() {
        let menuCoordinator = DefaultMenuCoordinator(self.navigationController)
        menuCoordinator.finishDelegate = self
        self.childCoordinators.append(menuCoordinator)
        menuCoordinator.pushMenuViewController()
    }
    
    func showSettingScene() {
        let settingCoordinator = DefaultSettingCoordinator(self.navigationController)
        settingCoordinator.finishDelegate = self
        self.childCoordinators.append(settingCoordinator)
        settingCoordinator.pushSettingViewController()
    }
    
}

extension DefaultHomeSceneCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        
    }
}
