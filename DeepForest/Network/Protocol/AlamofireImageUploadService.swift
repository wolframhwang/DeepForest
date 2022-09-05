//
//  AlamofireImageUploadService.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/05.
//

import Foundation
import Alamofire
import RxSwift

enum AlamofireImageUploadServiceError: Error {
    case unknownURL
    case emptyData
    case unknownError
}

extension AlamofireImageUploadServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknownURL:
            return "잘못된 주소 접근"
        case .emptyData:
            return "비어있는 데이터"
        case .unknownError:
            return "불명의 오류"
        }
    }
}

protocol AlamofireImageUploadService {
    func upload(with data: ImageItems,
                url urlString: String,
                headers: [String: String]?) -> Observable<Result<Data, AlamofireImageUploadServiceError>>
    
    
}
