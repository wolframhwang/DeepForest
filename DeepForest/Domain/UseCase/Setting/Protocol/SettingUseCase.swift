//
//  SettingUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import RxSwift
import RxCocoa

protocol SettingUseCase {
    var signOutPublisher: PublishRelay<Void> { get }
    var signInPublisher: PublishRelay<Void> { get }
    
    func makeSettingDataSource() -> Observable<[SettingSectionModel]>
    
    func signChecker()
}
