//
//  ViewModelType.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import Foundation

protocol ViewModelType {
    var coordinator: Coordinator? { get set }
    
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output
}
