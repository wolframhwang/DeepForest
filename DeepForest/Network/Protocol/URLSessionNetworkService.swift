//
//  URLSessionNetworkSErvice.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/01.
//

import Foundation
import RxSwift

protocol URLSessionNetworkService {
    func post<T: Codable>(
        _ data: T,
        url urlString: String,
        headers: [String: String]?
    ) -> Observable<Result<Data, URLSessionNetworkServiceError> >
    
    func fetch (
        url urlString: String,
        header: [String: String]?
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>>
    
    func delete<T: Codable>(
        _ data: T,
        url urlString: String,
        header: [String: String]?
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>>
    
    func update<T: Codable>(
        _ data: T,
        url urlString: String,
        header: [String: String]?
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>>
}
