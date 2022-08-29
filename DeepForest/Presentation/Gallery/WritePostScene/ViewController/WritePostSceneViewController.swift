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
    
    private lazy var contentTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 18)
        tv.textColor = .lightGray
        tv.text = contentTextViewPlaceHolder
        
        return tv
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
        titleTextView.rx.didEndEditing.subscribe(onNext: { [weak self] in
            guard let text = self?.titleTextView.text else { return }
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self?.titleTextView.text = titleTextViewPlaceHolder
                self?.titleTextView.textColor = .lightGray
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
            }
        })
        .disposed(by: disposeBag)
        
        contentTextView.rx.didEndEditing.subscribe(onNext: { [weak self] in
            guard let text = self?.contentTextView.text else { return }
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self?.contentTextView.text = contentTextViewPlaceHolder
                self?.contentTextView.textColor = .lightGray
            }
        })
        .disposed(by: disposeBag)
        
        contentTextView.rx.didBeginEditing.subscribe(onNext: { [weak self] in
            guard let text = self?.contentTextView.text else {
                return
            }
            if text == contentTextViewPlaceHolder {
                self?.contentTextView.text = nil
                self?.contentTextView.textColor = UIColor.label
            }
        })
        .disposed(by: disposeBag)
        
        contentTextView.rx.didChange
            .asDriver()
            .drive(onNext: { [weak self] in
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

        
        let input = WritePostSceneViewModel.Input()
        let output = viewModel?.transform(from: input)
        
    }
    
    func configureSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        [titleTextView, contentTextView]
            .forEach { subview in
                //containerView.addSubview(subview)
                containerView.addArrangedSubview(subview)
            }
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
        
        contentTextView.snp.makeConstraints { make in
            make.height.equalTo(60)
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
    }
}
