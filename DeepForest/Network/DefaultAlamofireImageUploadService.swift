//
//  DefaultAlamofireImageUploadService.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/05.
//

import Foundation
import Alamofire
import RxSwift

final class DefaultAlamofireImageUploadService: AlamofireImageUploadService {
    private enum HTTPMethod {
        static let get = "GET"
        static let post = "POST"
        static let delete = "DELETE"
    }
    
    func upload(with data: ImageItems, url urlString: String, headers: [String : String]?) -> Observable<Result<Data, AlamofireImageUploadServiceError>> {
        return request(with: data, url: urlString, headers: headers, method: HTTPMethod.post)
    }
    
    func request(with data: ImageItems,
                    url urlString: String,
                    headers: [String: String]? = nil,
                    method: String) -> Observable<Result<Data, AlamofireImageUploadServiceError>> {
        guard let url = URL(string: urlString) else {
            return Observable.error(AlamofireImageUploadServiceError.unknownURL)
        }
        print(url)
        print(self.createHeaders(headers: headers))
//http://52.78.99.238:8080/api/v1/image/list/MEMBER
//http://52.78.99.238:8080/api/v1/image/list/MEMBER

        return Observable<Result<Data, AlamofireImageUploadServiceError>>.create { emitter in
            AF.upload(multipartFormData: { multiData in
                if let imageArray = data.images {
                    for image in imageArray {
                        multiData.append(image,
                                         withName: "files",
                                         fileName: "\(image).jpg ",
                                         mimeType: "image/jpeg")
                    }
                }
            }, with: self.createHTTPRequest(of: url, with: headers, httpMethod: HTTPMethod.post))
            .responseJSON { response in
                guard let statusCode = response.response?.statusCode else {
                    emitter.onError(AlamofireImageUploadServiceError.unknownError)
                    return
                }
                print(statusCode, "STATUSCODE")
                switch statusCode {
                case 200..<300:
                    print("SUCCESS")
                    guard let data = response.data else {
                        emitter.onNext(.failure(AlamofireImageUploadServiceError.emptyData))
                        return
                    }
                    emitter.onNext(.success(data))
                    emitter.onCompleted()
                default:
                    emitter.onError(AlamofireImageUploadServiceError.unknownURL)
                    return
                }
            }
            
            
            
            
            return Disposables.create()
        }
        
    }
    
    private func createHeaders(headers: [String: String]?) -> HTTPHeaders? {
        guard let headers = headers else {
            return nil
        }
        var ret: HTTPHeaders = [:]
        headers.forEach { header in
            ret.add(name: header.key, value: header.value)
        }
        return ret
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
