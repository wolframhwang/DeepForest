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
    
    func pushPostViewScene(postId: Int) {
        self.postViewController.viewModel = PostViewModel(coordinator: self, postViewUseCase: DefaultPostViewUseCase(postId: postId, userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())))
        self.navigationController.pushViewController(postViewController, animated: true)
    }
    
    func showAlert(_ error: Error) {
        let alertView = UIAlertController(title: "포스트 실패",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.popChildScene(childCoordinator: self)
        }
        
        alertView.addAction(action)
        postViewController.present(alertView, animated: true)
    }
}

extension DefaultPostViewCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
    }
    
    func finish() {
        
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        navigationController.popViewController(animated: true)
        self.childCoordinators.removeLast()
    }
}
