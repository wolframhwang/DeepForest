//
//  SignUpCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation

protocol SignUpCoordinator: Coordinator {
    func showAlert(_ errorMessage: String)
    func popScene()
}
