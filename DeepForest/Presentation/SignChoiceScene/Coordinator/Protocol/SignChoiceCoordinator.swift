//
//  SignChoiceCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import Foundation

protocol SignChoiceCoordinator: Coordinator {
    func showSignInFlow()
    func showSignUpFlow()
    func joinNoSignInFlow()
}
