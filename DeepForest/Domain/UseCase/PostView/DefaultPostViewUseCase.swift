//
//  DefaultPostViewUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import RxCocoa
import RxSwift

final class DefaultPostViewUseCase: PostViewUseCase {
    private let postId: Int
    private let networkRepository: NetworkRepository
    private let userRepository: UserRepository
    
    var titleObservable = BehaviorSubject<String>(value: "")
    
    init(postId: Int,
         userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.postId = postId
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func fetchPost() -> Observable<String?> {
        return networkRepository.fetch(urlSuffix: <#T##String#>, queryItems: <#T##[String : String]?#>)
    }
}
