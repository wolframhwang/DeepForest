//
//  DefaultPostViewCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import UIKit

final class DefaultPostViewCoordinator: PostViewCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var postViewController: PostViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .detail
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.postViewController = PostViewController()
    }
    
    func start() {
        
    }
}
