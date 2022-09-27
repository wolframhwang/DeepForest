//
//  SignInfoUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignInfoUseCase {
    var titleInfo: BehaviorRelay<String> { get }
    var nickNameInfo: BehaviorRelay<String> { get }
    var emailInfo: BehaviorRelay<String> { get }
    var userNameInfo: BehaviorRelay<String> { get }

    func signOff() -> Observable<Void>
}
