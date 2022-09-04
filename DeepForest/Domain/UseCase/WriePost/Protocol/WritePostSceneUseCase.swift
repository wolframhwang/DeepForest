//
//  WritePostSceneUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa

protocol WritePostSceneUseCase {
    var titleObservable: BehaviorSubject<String> { get }
    
    var title: BehaviorSubject<String?> { get }
    var content: BehaviorSubject<NSAttributedString?> { get }
    
    func refreshToken() -> Observable<Bool>
    func postingMyContent() -> Observable<String?>
}
