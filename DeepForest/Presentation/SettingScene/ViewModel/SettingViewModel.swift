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
        let selection: Observable<IndexPath>
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
        let settingItems = settingUseCase.makeSettingDataSource()
        
        input.selection.filter { indexPath in
            return !(indexPath.section == 1 && indexPath.row == 1)
        }.subscribe(onNext: { [weak self] indexPath in
            if indexPath.section == 0 {
                self?.settingUseCase.signChecker()
            }
        })
        .disposed(by: disposeBag)
        
        settingUseCase.signInPublisher.subscribe(onNext: { [weak self] in
            // Todo: Go to SignIn Scene...
        })
        .disposed(by: disposeBag)
        
        settingUseCase.signOutPublisher
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
            self?.coordinator?.showSignInfoScene()
            
        })
        .disposed(by: disposeBag)

        return Output(settingItems: settingItems)
    }
}
