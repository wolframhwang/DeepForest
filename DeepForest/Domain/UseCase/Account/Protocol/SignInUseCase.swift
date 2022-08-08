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
    var userId: BehaviorSubject<String> { get }
    var userPw: BehaviorSubject<String> { get }
    
    func validateId(text: String)
    func validatePw(text: String)
    func signIn() -> Observable<Bool>
}
