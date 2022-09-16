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
import Lottie

class PostViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel: PostViewModel?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
        return activityIndicator
    }()
    
    private var contentWidth: CGFloat = 0
    private var mainView = PostContentview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        activityIndicator.startAnimating()
        configureSubviews()
        configureUI()
        setAttribute()
        DispatchQueue.main.async { [weak self] in
            self?.contentWidth = self?.mainView.contentLabel.frame.width ?? 0
        }
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
        
        let contents = Observable<NSAttributedString>.combineLatest(output.content, output.imageArrays) { [weak self] content, imageArrays -> NSAttributedString in
            return self?.generateImages(imageArrays, content: content) ?? NSAttributedString(string: "")
        }
        
        let activityIndicator = ActivityIndicator()
        
        let postContents = Driver.combineLatest(output.date.asDriver(onErrorDriveWith: .empty()),
                             output.writer.asDriver(onErrorDriveWith: .empty()),
                             output.title.asDriver(onErrorDriveWith: .empty()),
                             contents.asDriver(onErrorDriveWith: .empty()))
            .trackActivity(activityIndicator)
            .asDriver(onErrorDriveWith: .empty())
        
        postContents.drive { [weak self] date, writer, title, contents in
            self?.mainView.date.text = date
            self?.mainView.date.flex.markDirty()
            self?.mainView.titleLabel.text = title
            self?.mainView.titleLabel.flex.markDirty()
            self?.mainView.contentLabel.attributedText = contents
            self?.mainView.contentLabel.flex.markDirty()
            self?.mainView.write.text = writer
            self?.mainView.write.flex.markDirty()
            self?.mainView.setLayout()
            self?.mainView.titleContentSeparator.backgroundColor = .label
            self?.mainView.contentCommentSeparator.backgroundColor = .label
            self?.activityIndicator.stopAnimating()
        }
        .disposed(by: disposeBag)
        
        
        output.navigationTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
    }
    
    func generateImages(_ images: [(image: UIImage?, number: Int)],
                        content: String) -> NSAttributedString {
        if images.count == 0 {
            return NSAttributedString(string: content)
        }
        var offset = 0
        let attr: NSMutableAttributedString = NSMutableAttributedString(string: content)
        let slash: NSMutableAttributedString = NSMutableAttributedString(string: "\n")
        for image in images {
            var img = image.image ?? UIImage(named: "placeHolder")
            
            if let width = img?.size.width, let height = img?.size.height {
                if width > contentWidth {
                    img = img?.resized(to: CGSize(width: contentWidth, height: height * (contentWidth / width)))
                }
            }
            
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
        return attr
    }
}

enum CovertError: Error {
    case decodeFail
}
