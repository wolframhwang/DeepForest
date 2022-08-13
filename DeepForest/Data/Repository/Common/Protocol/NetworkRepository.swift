//
//  NetworkRepository.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/10.
//

import Foundation
import RxSwift

protocol NetworkRepository {
    func post() -> Observable<Bool>
}
