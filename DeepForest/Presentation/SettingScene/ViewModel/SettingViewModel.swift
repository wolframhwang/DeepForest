//
//  SettingViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias SettingSectionModel = SectionModel<String, String>

final class SettingViewModel: ViewModelType {
    private weak var coordinator: SettingCoordinator?
    private let settingUseCase: SettingUseCase
    private let disposeBag = DisposeBag()
    
    struct Input {
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let settingItems: Observable<[SettingSectionModel]>
    }
    
    init(coordinator: SettingCoordinator?,
         settingUseCase: SettingUseCase) {
        self.coordinator = coordinator
        self.settingUseCase = settingUseCase
    }
    
    func transform(from input: Input) -> Output {
        return Output(settingItems: settingUseCase.makeSettingDataSource())
    }
}
