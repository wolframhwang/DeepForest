//
//  AppStartUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol AppStartUseCase {
    func refreshToken() -> Observable<Bool>
}
