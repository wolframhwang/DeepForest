//
//  DefaultNetworkRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift

let baseURL = "http://52.78.99.238:8080"
let HTTPHeaders = ["Content-Type": "application/json"]

final class DefaultNetworkRepository: NetworkRepository {
    private let network: DefaultURLSessionNetworkService
    
    init(network : DefaultURLSessionNetworkService) {
        self.network = network
    }
    
    func post(accountInfo: AccountForSignIn) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network
            .post(accountInfo,
                  url: baseURL + "/api/v1/auth/signin",
                  headers: HTTPHeaders)
    }
    
    func post(accountInfo: AccountForSignUp) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network
            .post(accountInfo,
                  url: baseURL + "/api/v1/auth/signup",
                  headers: HTTPHeaders)
    }
    
    func post(tokenItem: TokenItem) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network
            .post(tokenItem,
                  url: baseURL + "/api/v1/auth/reissue",
                  headers: HTTPHeaders)
    }
    
    func fetch(urlSuffix: String, queryItems: [String: String]?) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network.fetch(url: baseURL + urlSuffix, queryItems: queryItems, header: HTTPHeaders)
    }

}
