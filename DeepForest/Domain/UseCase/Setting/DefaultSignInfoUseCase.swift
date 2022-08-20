//
//  DefaultSignInfoUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import Foundation
import RxSwift

final class DefaultSignInfoUseCase: SignInfoUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    private let disposeBag = DisposeBag()
    
    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    
}
