//
//  DefaultSettingUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class DefaultSettingUseCase: SettingUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    private let disposeBag = DisposeBag()
    
    var signOutPublisher = PublishRelay<Void>()
    var signInPublisher = PublishRelay<Void>()
    
    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
    }
    
    func signChecker() {
        let emitter = Observable<Void>.create { observe in
            observe.onNext(Void())
            observe.onCompleted()
            
            return Disposables.create()
        }
        guard (userRepository.fetchNickName()) != nil else {
            emitter
                .bind(to: signInPublisher)
                .disposed(by: disposeBag)
            return
        }
        emitter
            .bind(to: signOutPublisher)
            .disposed(by: disposeBag)
        
    }
    
    func makeSettingDataSource() -> Observable<[SettingSectionModel]> {
        let nickName = userRepository.fetchNickName() ?? "로그인 하시겠습니까?"
        let signInInfo = [nickName]
        let serviceInfo = ["버전 0.1", "오픈 소스 라이브러리"]
        
        return Observable<[SettingSectionModel]>.create { observer in
            observer.onNext([
                SectionModel<String, String>(model: "로그인 정보", items: signInInfo),
                SectionModel<String, String>(model: "앱 정보", items: serviceInfo)
            ])
            observer.onCompleted()
            
            return Disposables.create()
        }
        
    }
    
}
