//
//  DefaultGalleryListCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import UIKit

final class DefaultGalleryListCoordinator: GalleryListCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var galleryListViewController: GalleryListViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .galleryList
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.galleryListViewController = GalleryListViewController()
    }
    
    func start() {
        
    }
    
    func removeBackButtonTitle() {
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: self.galleryListViewController, action: nil)
        self.galleryListViewController.navigationItem.backBarButtonItem = backButtonItem
    }
    
    func pushGalleryListViewController(menuTableCellViewModel: MenuTableCellViewModel) {
        self.galleryListViewController.viewModel = GalleryListViewModel(coordinator: self, galleryListUseCase: DefaultGalleryListUseCase(networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService()), menuItem: menuTableCellViewModel))
        self.navigationController.pushViewController(self.galleryListViewController, animated: true)
        self.removeBackButtonTitle()
    }
    
    func pushGalleryPostList(GalleryInfo: Gallery) {
        let galleryPostListCoordinator = DefaultGalleryPostListCoordinator(self.navigationController)
        galleryPostListCoordinator.finishDelegate = self
        self.childCoordinators.append(galleryPostListCoordinator)
        galleryPostListCoordinator.pushGalleryPostList(GalleryInfo: GalleryInfo)
    }
}

extension DefaultGalleryListCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators.removeAll()
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func popChildScene(childCoordinator: Coordinator) {
        self.finishDelegate?.popChildScene(childCoordinator: self)
    }
    
    
}
