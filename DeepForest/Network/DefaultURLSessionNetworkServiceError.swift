//
//  DefaultURLSessionNetworkServiceError.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/01.
//

import Foundation
import RxSwift

enum URLSessionNetworkServiceError: Int, Error {
    case invalidURLError
    case unknownError
    case emptyDataError
}

extension URLSessionNetworkServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .emptyDataError:
            return "비어있는 데이터"
        case .invalidURLError:
            return "잘못된 주소"
        case .unknownError:
            return "이유 불명의 데이터"
        }
    }
}
