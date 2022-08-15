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
    var tokenInfo: BehaviorSubject<TokenItem?> { get }

    func refreshToken() -> Observable<Bool>
}
