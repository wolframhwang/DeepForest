//
//  DefaultSignInfoCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultSignInfoCoordinator: SignInfoCooridnator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var signInfoViewController: SignInfoViewController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .signInfo
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.signInfoViewController = SignInfoViewController()
    }
    
    func start() {
        
    }
    
    func pushSignInfoViewController() {
        self.signInfoViewController
            .viewModel = SignInfoViewModel(coordinator: self, signInfoUseCase: DefaultSignInfoUseCase(userRepository: DefaultUserRepository(), networkRepository: DefaultNetworkRepository(network: DefaultURLSessionNetworkService())))
        self.navigationController.pushViewController(self.signInfoViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}
