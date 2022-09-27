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
    private let alamofire: DefaultAlamofireImageUploadService?
    init(network : DefaultURLSessionNetworkService) {
        self.network = network
        self.alamofire = nil
    }
    
    init(network : DefaultURLSessionNetworkService,
         alamofire: DefaultAlamofireImageUploadService) {
        self.network = network
        self.alamofire = alamofire
    }
    func postWithImage(item: ImageItems, to: String, token: String) -> Observable<Result<Data?, AlamofireImageUploadServiceError>> {
        var header = ["Content-Type": "multipart/form-data"]
        header.updateValue("Bearer \(token)", forKey: "Authorization")
        
        guard let result = alamofire?.upload(with: item,
                                 url: baseURL + to,
                                             headers: header) else {
            return Observable.error(AlamofireImageUploadServiceError.unknownError)
        }
        return result
    }
    
    func postWithToken<T: Codable>(item: T, to: String, token: String) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        var header = HTTPHeaders
        header.updateValue("Bearer \(token)", forKey: "Authorization")
    
        return network
            .post(item,
                  url: baseURL + to,
                  headers: header)
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
    
    func fetch(urlSuffix: String, queryItems: [String: String]?,  token: String) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        var header = HTTPHeaders
        header.updateValue("Bearer \(token)", forKey: "Authorization")
        return network.fetch(url: baseURL + urlSuffix, queryItems: queryItems, header: header)
    }
    
    func fetch(url: String, queryItems: [String: String]? = nil) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return network.fetch(url: url, queryItems: queryItems, header: HTTPHeaders)
    }

}
