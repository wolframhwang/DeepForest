//
//  SignInCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/28.
//

import Foundation

protocol SignInCoordinator: Coordinator {
    func showAlert(_ errorMessage: Error)
}
