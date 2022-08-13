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
