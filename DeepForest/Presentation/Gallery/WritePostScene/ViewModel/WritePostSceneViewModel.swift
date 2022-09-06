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
        let content: Observable<NSAttributedString?>
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
            (content, isOK) -> NSAttributedString? in
            
            if isOK { return content }
            return nil
        }
        .bind(to: self.writePostSceneUseCase.content)
        .disposed(by: disposeBag)
        
        
        input.didTappedPostButton.drive(onNext: { [weak self] _ in
            self?.writePostSceneUseCase.refreshToken().subscribe(onNext: { [weak self] in
                if $0 {
                    guard let postingWithImage = self?.writePostSceneUseCase.postingMyContentWithImages() else {
                        return
                    }
                    
                    postingWithImage.observe(on: MainScheduler.asyncInstance).subscribe(onNext: { result in
                        result
                        switch result {
                        case .success(let data):
                            guard let data = data else { return }
                            do {
                                let response = try JSONDecoder().decode(ImageListResponseDTO.self, from: data)
                                if response.success {
                                    self?.writePostSceneUseCase.postingContent(imageURL: response.result).observe(on: MainScheduler.asyncInstance).subscribe(onNext: { success in
                                        if success != nil {
                                            self?.coordinator?.showAlert(AlamofireImageUploadServiceError.unknownError)
                                        } else {
                                            self?.coordinator?.dismissScene()
                                        }
                                    }, onError: { error in
                                        self?.coordinator?.showAlert(error)
                                    })
                                    .disposed(by: disposeBag)
                                } else {
                                    self?.coordinator?.showAlert(AlamofireImageUploadServiceError.unknownError)
                                }
                            } catch(let error) {
                                self?.coordinator?.showAlert(error)
                            }
                        case .failure(let error):
                            self?.coordinator?.showAlert(error)
                        }
                    }, onError: { error in
                        self?.coordinator?.showAlert(error)
                    })
                    .disposed(by: disposeBag)
                    
//                    Observable.combineLatest((self?.writePostSceneUseCase.postingMyContent())!, (self?.writePostSceneUseCase.postingMyContentWithImages())!).observe(on: MainScheduler.asyncInstance)
//                        .subscribe(onNext: { s1, s2 in
//                            if s2 != nil {
//                                self?.coordinator?.dismissScene()
//                            } else {
//                                self?.coordinator?.showAlert(AlamofireImageUploadServiceError.unknownError)
//                            }
//                        }, onError: { error in
//                            self?.coordinator?.showAlert(error)
//                        })
//                        .disposed(by: disposeBag)
                        
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
