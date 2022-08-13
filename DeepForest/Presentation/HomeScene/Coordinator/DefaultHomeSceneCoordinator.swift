//
//  DefaultMainSceneCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift

final class DefaultHomeSceneCoordinator: MainSceneCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var mainSceneViewController: HomeSceneViewController
    var childCoordinators: [Coordinator]
    var type: CoordinatorType = .home
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mainSceneViewController = HomeSceneViewController()
    }
    
    func start() {
        
    }
    
}
