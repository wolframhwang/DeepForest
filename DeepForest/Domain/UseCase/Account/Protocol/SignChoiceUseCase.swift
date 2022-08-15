//
//  SignChoiceUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignChoiceUseCase {
    func refreshToken() -> Observable<Bool>
}
