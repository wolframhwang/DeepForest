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
import PinLayout
import Lottie

class PostViewController: UIViewController {
    var disposeBag = DisposeBag()
    var viewModel: PostViewModel?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        return activityIndicator
    }()
    
    private lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: view.frame.width,
                           height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        
        return commentInputAccessoryView
    }()
    
    private var contentWidth: CGFloat = 0
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
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension PostViewController {
    func configureSubviews() {
        self.view.addSubview(activityIndicator)
        
        DispatchQueue.main.async { [weak self] in
            self?.contentWidth = self?.mainView.contentLabel.frame.width ?? 0
            self?.activityIndicator.pin
                .width(80).height(80)
                .vCenter()
                .hCenter()
            self?.activityIndicator.startAnimating()
        }
    }
    
    func configureUI() {
       
    }
    
    func setAttribute() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        mainView.scrollView.keyboardDismissMode = .interactive
        mainView.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
//        mainView.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
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
                                                contents.asDriver(onErrorDriveWith: .empty()),
                                                output.comments.asDriver(onErrorDriveWith: .empty()))
            .trackActivity(activityIndicator)
            .asDriver(onErrorDriveWith: .empty())
        
        postContents.drive { [weak self] date, writer, title, contents, comments in
            self?.mainView.date.text = date
            self?.mainView.date.flex.markDirty()
            self?.mainView.titleLabel.text = title
            self?.mainView.titleLabel.flex.markDirty()
            self?.mainView.contentLabel.attributedText = contents
            self?.mainView.contentLabel.flex.markDirty()
            self?.mainView.write.text = writer
            self?.mainView.write.flex.markDirty()
            self?.mainView.commentLabel.text = "  댓글(\(comments.count))"
            self?.mainView.commentLabel.flex.markDirty()
            
            self?.mainView.titleContentSeparator.backgroundColor = .label
            self?.mainView.contentCommentSeparator.backgroundColor = .label
            self?.mainView.makeComment(comments)
            self?.mainView.setLayout()
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?, var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = mainView.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        mainView.scrollView.contentInset = contentInset
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        mainView.scrollView.contentInset = UIEdgeInsets.zero
        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset
                
    }
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        containerView.endEdit()
    }
}

enum CovertError: Error {
    case decodeFail
}
