//
//  DefaultGalleryPostListCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import Foundation
import UIKit

final class DefaultGalleryPostListCoordinator: GalleryPostListCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var galleryPostListViewController: GalleryPostListViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .gallery
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.galleryPostListViewController = GalleryPostListViewController()
    }
    
    func start() {
        
    }
    
    func removeBackButtonTitle() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self.galleryPostListViewController, action: nil)
        self.galleryPostListViewController.navigationItem.backBarButtonItem = backButtonItem
    }
    
    func pushGalleryPostList(GalleryInfo: Gallery) {
        self.galleryPostListViewController.viewModel = GalleryPostListViewModel(coordinator: self, galleryPostListUseCase: DefaultGalleryPostListUseCase(networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService()), galleryInfo: GalleryInfo))
        self.navigationController.pushViewController(galleryPostListViewController, animated: true)
        removeBackButtonTitle()
    }
    
    func pushPostViewScene(postId: Int) {
        let postViewSceneCoordinator = DefaultPostViewCoordinator(self.navigationController)
        postViewSceneCoordinator.finishDelegate = self
        self.childCoordinators.append(postViewSceneCoordinator)        
        postViewSceneCoordinator.pushPostViewScene(postId: postId)
    }
    
    func presentWritePostScene(galleryId: Int) {
        let writePostSceneCoordinator = DefaultWritePostSceneCoordinator(self.navigationController)
        writePostSceneCoordinator.finishDelegate = self
        self.childCoordinators.append( writePostSceneCoordinator)
        writePostSceneCoordinator.presentWritePostScene(galleryId: galleryId)
    }
}

extension DefaultGalleryPostListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        
    }
    
    func finish() {
        
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        navigationController.popViewController(animated: true)
        self.childCoordinators.removeLast()
    }
    
    func finishSign(childCoordinator: Coordinator, with success: Bool) {
        
    }
}
