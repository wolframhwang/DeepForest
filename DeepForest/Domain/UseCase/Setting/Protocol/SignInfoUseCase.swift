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
    var idInfo: BehaviorRelay<String> { get }
    
    func signOff() -> Observable<Void>
}
