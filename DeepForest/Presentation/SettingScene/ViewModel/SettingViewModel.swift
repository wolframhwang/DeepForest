//
//  SettingViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: ViewModelType {
    private weak var coordinator: SettingCoordinator?
    //private let settingUseCase: SettingUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(from input: Input) -> Output {
        return Output()
    }
}
