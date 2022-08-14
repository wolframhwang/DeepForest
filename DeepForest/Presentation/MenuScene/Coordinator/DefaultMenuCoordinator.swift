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
    
    
}
