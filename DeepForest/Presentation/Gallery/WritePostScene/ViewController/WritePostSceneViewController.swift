//
//  WritePostSceneViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

let titleTextViewPlaceHolder = "제목을 입력하세요"
let contentTextViewPlaceHolder = "내용을 입력하세요"

class WritePostSceneViewController: UIViewController {
    var viewModel: WritePostSceneViewModel?
    let disposeBag = DisposeBag()
    
    private lazy var scrollView: UIScrollView = {
        let scv = UIScrollView()
        scv.isScrollEnabled = true
        
        
        return scv
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var titleTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = .lightGray
        tv.text = titleTextViewPlaceHolder
        
        return tv
    }()
    
    private lazy var lineView = UIView()
    
    private lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .lightGray
        tv.text = contentTextViewPlaceHolder
        
        return tv
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.left")
        
        return button
    }()
    
    private lazy var postButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        let font = UIFont.systemFont(ofSize: 18, weight: .regular)
        let color = UIColor.systemRed
        button.title = "등록"
        button.style = .plain
        button.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], for: .normal)
        
        return button
    }()
    
    private lazy var pickContainerView = UIView()
    
    private lazy var pictureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
}

extension WritePostSceneViewController {
    func bindViewModel() {
        let titleIsOK = BehaviorSubject<Bool>(value: false)
        titleTextView.rx.didEndEditing.subscribe(onNext: { [weak self] in
            guard let text = self?.titleTextView.text else { return }
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self?.titleTextView.text = titleTextViewPlaceHolder
                self?.titleTextView.textColor = .lightGray
                titleIsOK.onNext(false)
            }
        })
        .disposed(by: disposeBag)
        
        titleTextView.rx.didBeginEditing.subscribe(onNext: { [weak self] in
            guard let text = self?.titleTextView.text else {
                return
            }
            if text == titleTextViewPlaceHolder {
                self?.titleTextView.text = nil
                self?.titleTextView.textColor = UIColor.label
                titleIsOK.onNext(true)
            }
        })
        .disposed(by: disposeBag)
        
        let contentIsOK = BehaviorSubject<Bool>(value: false)
        
        let contentEndEdit = PublishSubject<Void>()
        
        contentTextView.rx.didEndEditing.subscribe(onNext: { _ in
            contentEndEdit.onNext(Void())
        })
        .disposed(by: disposeBag)
        
        contentEndEdit.asDriver(onErrorDriveWith: .empty())
            .drive(onNext: {[weak self] in
                guard let text = self?.contentTextView.text else { return }
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self?.contentTextView.text = contentTextViewPlaceHolder
                    self?.contentTextView.textColor = .lightGray
                    contentIsOK.onNext(false)
                }
            })
            .disposed(by: disposeBag)
        
        let contentBeginEdit = PublishSubject<Void>()
        
        contentTextView.rx.didBeginEditing.subscribe(onNext: { _ in
            contentBeginEdit.onNext(Void())
        })
        .disposed(by: disposeBag)
        
        contentBeginEdit.asDriver(onErrorDriveWith: .empty()).drive(onNext: { [weak self] in
            guard let text = self?.contentTextView.text else {
                return
            }
            self?.contentTextView.textColor = UIColor.label
            self?.contentTextView.font = UIFont.systemFont(ofSize: 18)
            if text == contentTextViewPlaceHolder {
                self?.contentTextView.text = nil
                contentIsOK.onNext(true)
            }
        })
        .disposed(by: disposeBag)
        
        let contentDidChagne = PublishSubject<Void>()
        
        contentDidChagne.subscribe(onNext: { [weak self] in
            guard let width = self?.contentTextView.frame.width else {
                return
            }
            
            let size = CGSize(width: width, height: .infinity)
            guard let estimateSize = self?.contentTextView.sizeThatFits(size) else {
                return
            }
            self?.contentTextView.constraints.forEach({ constraint in
                if estimateSize.height > 60 {
                    if constraint.firstAttribute == .height {
                        constraint.constant = estimateSize.height
                    }
                }
            })
        })
        .disposed(by: disposeBag)
        
        contentTextView.rx.didChange
            .asDriver()
            .drive(onNext: { _ in
                contentDidChagne.onNext(Void())
            })
            .disposed(by: disposeBag)
        
        let input = WritePostSceneViewModel
            .Input(title: titleTextView.rx.text.asObservable(),
                   titleIsOK: titleIsOK.asObservable(),
                   content: contentTextView.rx.text.asObservable(),
                   contentIsOK: contentIsOK.asObservable(),
                   didTappedPostButton: postButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
                .asDriver(onErrorDriveWith: .empty()),
                   didTappedCancelButton: cancelButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
                .asDriver(onErrorDriveWith: .empty()),
                   didTappedAddPictueButton: pictureButton.rx.tap
                .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
                .asDriver(onErrorDriveWith: .empty()))
        
        let output = viewModel?.transform(from: input)
        
        output?.viewTitle.drive(onNext: { [weak self] text in
            self?.title = text
        }).disposed(by: disposeBag)
        
        output?.selectedImage.drive(onNext : { [weak self] image in
            contentBeginEdit.onNext(Void())
            let attachement = NSTextAttachment()
            attachement.image = image
            let size = attachement.image?.size
            guard let width = size?.width else { return }
            guard let height = size?.height else { return }
            guard let tWidth = self?.contentTextView.frame.width else {
                return
            }
            if width > tWidth {
                attachement.bounds.size = CGSize(width: tWidth, height: height * (tWidth / width))
            }
            let attachmentString = NSAttributedString(attachment: attachement)
            
            self?.contentTextView.textStorage.insert(attachmentString, at: self?.contentTextView.text.count ?? 0)
            
            if let position = self?.contentTextView.endOfDocument {
                self?.contentTextView.selectedTextRange = self?.contentTextView.textRange(from:position, to:position)
            }
            
            contentDidChagne.onNext(Void())
            contentEndEdit.onNext(Void())
        })
        .disposed(by: disposeBag)
    }
    
    func configureSubviews() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = postButton
        
        view.addSubview(scrollView)
        view.addSubview(pickContainerView)
        
        scrollView.addSubview(containerView)
        [titleTextView, lineView, contentTextView]
            .forEach { subview in
                //containerView.addSubview(subview)
                containerView.addArrangedSubview(subview)
            }
        
        pickContainerView.addSubview(pictureButton)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let safeArea = view.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(safeArea)
        }
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width).inset(10)
            make.leading.trailing.top.bottom.equalToSuperview().inset(10)
        }
        
        titleTextView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height - 82)
        }
        
        pickContainerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        pictureButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
    }
    
    func setAttribute() {
        let heightAnchor = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightAnchor.priority = .defaultHigh
        heightAnchor.isActive = true
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        lineView.backgroundColor = .label
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        pickContainerView.backgroundColor = .systemBackground
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        self.pickContainerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-contentInset.bottom)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        self.pickContainerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
