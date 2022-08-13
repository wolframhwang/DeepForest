//
//  DefaultNetworkRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift

final class DefaultNetworkRepository: NetworkRepository {
    private let network: DefaultURLSessionNetworkService
    
    init(network : DefaultURLSessionNetworkService) {
        self.network = network
    }
    
    func post(accountInfo: AccountForSignIn) -> Observable<Bool> {
        let response = network.post(accountInfo,
                                    url: <#T##String#>,
                                    headers: nil)
    }
    
}
