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
    func presentWritePostScene(galleryType: GalleryType) {
        self.writePostSceneViewController.viewModel = WritePostSceneViewModel(coordinator: self, writePostSceneUseCase: DefaultWritePostSceneUseCase(gallerType: galleryType))
        self.navigationController.pushViewController(self.writePostSceneViewController, animated: true)
    }
}
