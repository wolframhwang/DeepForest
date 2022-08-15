//
//  GalleryListCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation

protocol GalleryListCoordinator: Coordinator {
    func pushGalleryListViewController(menuViewModel: MenuTableCellViewModel)
}
