//
//  SignInUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/02.
// M V VM model, view, viewModel
// VM Logic Repsoitory  Coordi

import Foundation
import RxSwift

protocol SignInUseCase {
    var signInInfo: BehaviorSubject<AccountForSignIn> { get }
    
    func singIn() -> Observable<Bool>
}
