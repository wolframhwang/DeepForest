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
    
    
}