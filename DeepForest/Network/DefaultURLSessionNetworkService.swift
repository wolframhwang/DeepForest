//
//  DefaultURLSessionNetworkService.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import Foundation
import RxSwift

final class DefaultURLSessionNetworkService: URLSessionNetworkService {
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    func post<T: Codable>(_ data: T,
                 url urlString: String,
                 headers: [String : String]?) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return request(with: data, url: urlString, headers: headers, method: HTTPMethod.post)
    }
    
    func fetch(url urlString: String, header: [String : String]?) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return request(url: urlString, headers: header, method: HTTPMethod.get)
    }
    
    func fetch(url urlString: String, queryItems: [String: String]?, header: [String : String]?) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        return request(url: urlString, queryItems: queryItems, headers: header, method: HTTPMethod.get)
    }
    
    func delete<T>(_ data: T, url urlString: String, header: [String : String]?) -> Observable<Result<Data, URLSessionNetworkServiceError>> where T : Decodable, T : Encodable {
        return request(url: urlString, headers: header, method: HTTPMethod.delete)
    }
    
    private func URLGenerate(urlString : String, queryItems: [String: String]?) -> String {
        var urlString = urlString, index = 0
        
        guard let queryItems = queryItems else {
            return urlString
        }
        urlString += "?"

        for item in queryItems {
            if index != 0 {
                urlString += "&"
            }
            urlString += "\(item.key)=\(item.value)"
            index += 1
        }
        return urlString
    }
    
    private func request(
        url urlString: String,
        queryItems: [String: String]? = nil,
        headers: [String: String]? = nil,
        method: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        guard let url = URL(string: URLGenerate(urlString: urlString, queryItems: queryItems)) else {
            return Observable.error(URLSessionNetworkServiceError.invalidURLError)
        }
        
        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
            let request = self.createHTTPRequest(of: url,
                                                 with: headers,
                                                 httpMethod: method)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    emitter.onError(URLSessionNetworkServiceError.unknownError)
                    return
                }
                
                if error != nil {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    emitter.onNext(.failure(.emptyDataError))
                    return
                }
                
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func request(
        url urlString: String,
        headers: [String: String]? = nil,
        method: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        guard let url = URL(string: urlString) else {
            return Observable.error(URLSessionNetworkServiceError.invalidURLError)
        }
        
        
        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
            let request = self.createHTTPRequest(of: url,
                                                 with: headers,
                                                 httpMethod: method)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    emitter.onError(URLSessionNetworkServiceError.unknownError)
                    return
                }
                
                if error != nil {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    emitter.onNext(.failure(.emptyDataError))
                    return
                }
                
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func request<T: Codable>(
        with bodyData: T,
        url urlString: String,
        headers: [String: String]? = nil,
        method: String
    ) -> Observable<Result<Data, URLSessionNetworkServiceError>> {
        guard let url = URL(string: urlString),
              let httpBody = self.createPostPayload(from: bodyData) else {
                  return Observable.error(URLSessionNetworkServiceError.emptyDataError)
              }
        return Observable<Result<Data, URLSessionNetworkServiceError>>.create { emitter in
            let request = self.createHTTPRequest(of: url, with: headers, httpMethod: method, with: httpBody)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    emitter.onError(URLSessionNetworkServiceError.unknownError)
                    return
                }
                if error != nil {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                guard 200...299 ~= httpResponse.statusCode else {
                    emitter.onError(self.configureHTTPError(errorCode: httpResponse.statusCode))
                    return
                }
                guard let data = data else {
                    emitter.onNext(.failure(.emptyDataError))
                    return
                }
                emitter.onNext(.success(data))
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func createPostPayload<T: Codable>(from requestBody: T) -> Data? {
        if let data = requestBody as? Data {
            return data
        }
        return try? JSONEncoder().encode(requestBody)
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return URLSessionNetworkServiceError(rawValue: errorCode) ?? URLSessionNetworkServiceError.unknownError
    }
    
    private func createHTTPRequest(
        of url: URL,
        with headers: [String: String]?,
        httpMethod: String,
        with body: Data? = nil
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        headers?.forEach({ header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        })
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
    
}

