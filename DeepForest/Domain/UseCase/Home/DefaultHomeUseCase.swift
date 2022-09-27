//
//  DefaultHomeUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultHomeUseCase: HomeUseCase {
    private let networkRepository: NetworkRepository
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
}
