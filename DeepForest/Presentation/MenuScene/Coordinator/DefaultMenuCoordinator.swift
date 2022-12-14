//
//  DefaultMenuCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift

final class DefaultMenuCoordinator: MenuCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var menuViewController: MenuViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .menu
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.menuViewController = MenuViewController()
    }
    
    func start() {
        
    }
    
    func removeBackButtonTitle() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self.menuViewController, action: nil)
        self.menuViewController.navigationItem.backBarButtonItem = backButtonItem
    }
    
    func pushMenuViewController() {
        self.menuViewController.viewModel = MenuViewModel(coordinator: self)
        self.navigationController.pushViewController(self.menuViewController, animated: true)
        self.removeBackButtonTitle()
    }
    
    func pushGalleryListViewController(menuTableCellViewModel: MenuTableCellViewModel) {
        let galleryListCoordinator = DefaultGalleryListCoordinator(self.navigationController)
        galleryListCoordinator.finishDelegate = self
        self.childCoordinators.append(galleryListCoordinator)        
        galleryListCoordinator.pushGalleryListViewController(menuTableCellViewModel: menuTableCellViewModel)
    }
    
}

extension DefaultMenuCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        self.finishDelegate?.popChildScene(childCoordinator: self)
    }            
}
