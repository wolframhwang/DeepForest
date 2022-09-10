//
//  PostViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Kingfisher
import FlexLayout

class PostViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel: PostViewModel?
    
    private var mainView = PostContentview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
    
    override func loadView() {
        view = mainView
    }
}

extension PostViewController {
    func configureSubviews() {
        
    }
    
    func configureUI() {
        
    }
    
    func setAttribute() {
        
    }
    
    func bindViewModel() {
        
        let input = PostViewModel.Input()
        
        guard let output = viewModel?.transformed(from: input, disposeBag: disposeBag) else {
            return
        }
        
        
        output.title.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] title in
                self?.mainView.titleLabel.text = title
                self?.mainView.titleLabel.flex.markDirty()
            })
            .disposed(by: disposeBag)
        
        output.writer.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] writer in
                self?.mainView.write.text = writer
                self?.mainView.write.flex.markDirty()
            })
            .disposed(by: disposeBag)
        
        output.date.observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] date in
                self?.mainView.date.text = date
                self?.mainView.date.flex.markDirty()
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(output.imageArrays, output.content).asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] imageArray, content in
                self?.generateImages(imageArray, content: content).asDriver(onErrorDriveWith: .empty()).drive(onNext: { [weak self] content in
                    self?.mainView.contentLabel.attributedText = content
                    self?.mainView.contentLabel.flex.markDirty()
                    self?.mainView.setLayout()
                })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                self?.mainView.setLayout()
            })
            .disposed(by: disposeBag)
        
        output.navigationTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
    }
    
    func generateImages(_ images: [ImageArrayResponseDTO]?,
                        content: String) -> Observable<NSAttributedString> {
        guard let images = images else {
            return Observable.error(CovertError.decodeFail)
        }
        let tWidth = self.mainView.contentLabel.frame.size.width
        return Observable<NSAttributedString>.create { emitter in
            if images.count == 0 {
                emitter.onNext(NSAttributedString(string: content))
                emitter.onCompleted()
            }
            var offset = 0
            let attr: NSMutableAttributedString = NSMutableAttributedString(string: content)
            for image in images {
                var img: UIImage?
                let url = URL(string: image.url)
                let data = try? Data(contentsOf: url!)
                img = UIImage(data: data!)
                                
                if let width = img?.size.width, let height = img?.size.height {
                    if width > tWidth {
                        img = img?.resized(to: CGSize(width: tWidth, height: height * (tWidth / width)))
                    }
                }
                
                let slash: NSMutableAttributedString = NSMutableAttributedString(string: "\n")
                let attachment = NSTextAttachment()
                attachment.image = img
                let attachString = NSAttributedString(attachment: attachment)
                attr.insert(slash, at: image.number + offset)
                offset += 1
                attr.insert(attachString, at: image.number + offset)
                offset += 1
                attr.insert(slash, at: image.number + offset)
                offset += 1
            }
            emitter.onNext(attr)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
}

enum CovertError: Error {
    case decodeFail
}
