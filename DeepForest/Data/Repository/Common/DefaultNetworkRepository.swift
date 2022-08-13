//
//  DefaultNetworkRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift

let baseURL = "http://3.36.205.23:8080"
let HTTPHeaders = ["Content-Type": "application/json"]

final class DefaultNetworkRepository: NetworkRepository {
    private let network: DefaultURLSessionNetworkService
    
    init(network : DefaultURLSessionNetworkService) {
        self.network = network
    }
    
    func post(accountInfo: AccountForSignIn) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network
            .post(accountInfo,
                  url: baseURL + "/api/v1/auth/signIn",
                  headers: nil)
    }
    
}
