//
//  DefaultWritePostSceneCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa
final class DefaultWritePostSceneCoordinator: WritePostSceneCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var writePostSceneViewController: WritePostSceneViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .compose
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.writePostSceneViewController = WritePostSceneViewController()
    }
    
    func start() {
        
    }
    func presentWritePostScene(galleryId: Int) {
        self.writePostSceneViewController.viewModel = WritePostSceneViewModel(coordinator: self, writePostSceneUseCase: DefaultWritePostSceneUseCase(galleryId: galleryId, userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())))
        self.navigationController.pushViewController(self.writePostSceneViewController, animated: true)
    }
    
    func popScene() {
        self.finishDelegate?.popChildScene(childCoordinator: self)
    }
    
    func showAlert(_ error: Error) {
        let alertView = UIAlertController(title: "포스트 실패",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alertView.addAction(action)
        writePostSceneViewController.present(alertView, animated: true)
    }
}
