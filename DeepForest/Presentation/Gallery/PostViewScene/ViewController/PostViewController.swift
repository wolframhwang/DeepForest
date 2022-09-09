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

class PostViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel: PostViewModel?
    private lazy var titleContentSeparator = UIView()
    private lazy var contentCommentSeparator = UIView()
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var writeInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var write: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        
        
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension PostViewController {
    func configureSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        [writeInfoStackView, titleContentSeparator, contentLabel, contentCommentSeparator].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        
        [titleLabel, write, date].forEach { subview in
            writeInfoStackView.addArrangedSubview(subview)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(safeArea)
        }
        
        stackView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.leading.trailing.top.bottom.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        titleContentSeparator.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        contentCommentSeparator.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
    
    }
    
    func setAttribute() {
        
    }
    
    func bindViewModel() {
        
        let input = PostViewModel.Input()
        
        guard let output = viewModel?.transformed(from: input, disposeBag: disposeBag) else {
            return
        }
        
        
        output.title.observe(on: MainScheduler.asyncInstance)
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.content.observe(on: MainScheduler.asyncInstance)
            .bind(to: contentLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.writer.observe(on: MainScheduler.asyncInstance)
            .bind(to: write.rx.text)
            .disposed(by: disposeBag)
        
        output.date.observe(on: MainScheduler.asyncInstance)
            .bind(to: date.rx.text)
            .disposed(by: disposeBag)
        
        Driver.combineLatest(output.content.asDriver(onErrorDriveWith: .empty()), output.imageArrays.asDriver(onErrorDriveWith: .empty())).drive(onNext: { [weak self] content, imageArray in
            self?.contentLabel.attributedText = NSAttributedString(string: content)
            self?.generateImages(imageArray)
            [self?.titleContentSeparator, self?.contentCommentSeparator].forEach { subview in
                subview?.backgroundColor = .label
            }
        })
        .disposed(by: disposeBag)
        
        output.navigationTitle
            .bind(to: self.rx.title)
            .disposed(by: disposeBag)
    }
    
    private func width() -> Observable<CGFloat> {
        return Observable.create { [weak self] emitter in
            emitter.onNext(self?.stackView.frame.width ?? 0)
            emitter.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func generateImages(_ images: [ImageArrayResponseDTO]?) {
        guard let images = images else {
            return
        }
        if images.count == 0 { return }
        var offset = 0
        for image in images {
            DispatchQueue.main.async { [weak self] in
                var img: UIImage?
                let url = URL(string: image.url)
                let data = try? Data(contentsOf: url!)
                img = UIImage(data: data!)
            
                
                let tWidth = self?.contentLabel.frame.width ?? 0
                if let width = img?.size.width, let height = img?.size.height {
                    if width > tWidth {
                        img = img?.resized(to: CGSize(width: tWidth, height: height * (tWidth / width)))
                    }
                }
                
                let attr: NSMutableAttributedString = NSMutableAttributedString(attributedString: self?.contentLabel.attributedText ?? NSAttributedString(string: ""))
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
                self?.contentLabel.attributedText = attr
                self?.contentLabel.font = .systemFont(ofSize: 18)
                self?.contentLabel.sizeToFit()
            }
            
        }
        
    }
}
