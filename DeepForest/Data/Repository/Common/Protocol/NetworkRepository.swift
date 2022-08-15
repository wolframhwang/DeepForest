//
//  NetworkRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/10.
//

import Foundation
import RxSwift

protocol NetworkRepository {
    func post(accountInfo: AccountForSignIn) -> Observable<Result<Data, URLSessionNetworkServiceError>>
    func post(accountInfo: AccountForSignUp) -> Observable<Result<Data, URLSessionNetworkServiceError>>
    func post(tokenItem: TokenItem) -> Observable<Result<Data, URLSessionNetworkServiceError>>
}
