//
//  DefaultSignInfoUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultSignInfoUseCase: SignInfoUseCase {
    private let userRepository: UserRepository
    private let networkRepository: NetworkRepository
    
    private let disposeBag = DisposeBag()
    
    var userNameInfo = BehaviorRelay<String>(value: "")
    var nickNameInfo = BehaviorRelay<String>(value: "")
    var emailInfo = BehaviorRelay<String>(value: "")
    var titleInfo = BehaviorRelay<String>(value: "내 정보")
    
    init(userRepository: UserRepository,
         networkRepository: NetworkRepository) {
        self.userRepository = userRepository
        self.networkRepository = networkRepository
        nickNameInfo.accept(userRepository.fetchNickName() ?? "닉네임 로드 실패")
        userNameInfo.accept(userRepository.fetchUserName() ?? "유저네임 로드 실패")
        emailInfo.accept(userRepository.fetchEmail() ?? "이메일 로드 실패")        
    }
    
    func signOff() -> Observable<Void> {
        userRepository.deleteSignInfo()
        return Observable<Void>.create { observe in
            observe.onNext(Void())
            observe.onCompleted()
            
            return Disposables.create()
        }
    }
}
