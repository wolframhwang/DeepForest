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
}
