//
//  WritePostSceneViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class WritePostSceneViewModel: NSObject, ViewModelType {
    private weak var coordinator: WritePostSceneCoordinator?
    private let writePostSceneUseCase: WritePostSceneUseCase
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        return imagePickerController
    }()
    private let imageSubject = PublishSubject<UIImage?>()
    
    struct Input {
        let title: Observable<String?>
        let titleIsOK: Observable<Bool>
        let content: Observable<String?>
        let contentIsOK: Observable<Bool>
        let didTappedPostButton: Driver<Void>
        let didTappedCancelButton: Driver<Void>
        let didTappedAddPictueButton: Driver<Void>
    }
    
    struct Output {
        let viewTitle: Driver<String>
        let selectedImage: Driver<UIImage?>
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
        })
        .disposed(by: disposeBag)
        
        input.didTappedAddPictueButton.drive(onNext: { [weak self] _ in
            self?.coordinator?.selectPictureToAlbum(imagePickerController: self?.imagePickerController)
        })
        .disposed(by: disposeBag)
        
        return Output(viewTitle: writePostSceneUseCase.titleObservable.asDriver(onErrorJustReturn: "게시판"),
                      selectedImage: imageSubject.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension WritePostSceneViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
        }
        
        imageSubject.onNext(selectImage)
        picker.dismiss(animated: true)
    }
}
