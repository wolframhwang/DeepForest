//
//  WritePostSceneViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa

final class WritePostSceneViewModel: ViewModelType {
    private weak var coordinator: WritePostSceneCoordinator?
    private let writePostSceneUseCase: WritePostSceneUseCase
    
    struct Input {
        let title: Observable<String?>
        let titleIsOK: Observable<Bool>
        let content: Observable<String?>
        let contentIsOK: Observable<Bool>
        let didTappedPostButton: Driver<Void>
        let didTappedCancelButton: Driver<Void>
    }
    
    struct Output {
        let viewTitle: Driver<String>
    }
    
    init(coordinator: WritePostSceneCoordinator?,
         writePostSceneUseCase: WritePostSceneUseCase) {
        self.coordinator = coordinator
        self.writePostSceneUseCase = writePostSceneUseCase
    }
    
    func transform(from input: Input) -> Output {
        let disposeBag = DisposeBag()
        input.title.withLatestFrom(input.titleIsOK) { (title, isOK) -> String? in
            if isOK { return title }
            return nil
        }
        .bind(to: self.writePostSceneUseCase.title)
        .disposed(by: disposeBag)
        
        input.content.withLatestFrom(input.contentIsOK) {
            (content, isOK) -> String? in
            if isOK { return content }
            return nil
        }
        .bind(to: self.writePostSceneUseCase.content)
        .disposed(by: disposeBag)
        
        
        input.didTappedPostButton.drive(onNext: { [weak self] _ in
            self?.writePostSceneUseCase.refreshToken().subscribe(onNext: { [weak self] in
                if $0 {
                    self?.writePostSceneUseCase.postingMyContent().observe(on: MainScheduler.asyncInstance)
                        .subscribe(onNext: { [weak self] response in
                            self?.coordinator?.dismissScene()
                        }, onError: { error in
                            self?.coordinator?.showAlert(error)
                        })
                        .disposed(by: disposeBag)
                }
            })
            .disposed(by: disposeBag)
        })
        .disposed(by: disposeBag)
        
        input.didTappedCancelButton.drive(onNext: { [weak self] _ in
            self?.coordinator?.dismissScene()
            print("CANCEL")
        })
        .disposed(by: disposeBag)
        
        return Output(viewTitle: writePostSceneUseCase.titleObservable.asDriver(onErrorJustReturn: "게시판"))
    }
}
