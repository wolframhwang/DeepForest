//
//  MainSceneCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift

protocol HomeSceneCoordinator: Coordinator {
    func showMenuScene()
    func showSettingScene()
}
