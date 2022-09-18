//
//  CommentInputTextView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CommentInputTextView: UITextView {
    private let disposeBag = DisposeBag()
    
    fileprivate let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "댓글을 입력해 주세요."
        
        return label
    }()
    
    func showPlaceHolderLabel() {
        placeholderLabel.isHidden = false
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        sharedInit()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func bind() {
        self.rx.text.subscribe(onNext: { [weak self] text in
            guard let text = text else {
                self?.placeholderLabel.isHidden = false
                return
            }
            self?.placeholderLabel.isHidden = !text.isEmpty
        })
        .disposed(by: disposeBag)
    }
    
    func sharedInit() {
        backgroundColor = .tertiarySystemBackground
        
        addSubview(placeholderLabel)
        //placeholderLabel.backgroundColor = .red
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
    }
}
