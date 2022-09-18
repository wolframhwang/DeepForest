//
//  CommentInputAccessoryView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/18.
//

import UIKit

class CommentInputAccessoryView: UIView {
    
    let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 12
        tv.font = UIFont.systemFont(ofSize: 15)
        return tv
    }()
    
    let submitButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setTitle("등록", for: .normal)
        sb.setTitleColor(.label, for: .normal)
        
        return sb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    private func sharedInit() {
        backgroundColor = .secondarySystemBackground
        autoresizingMask = .flexibleHeight
        
        addSubview(submitButton)
        addSubview(commentTextView)
        
        submitButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(12)
            make.height.width.equalTo(50)
        }
        
        commentTextView.snp.makeConstraints { make in
            make.trailing.equalTo(submitButton.snp.leading).offset(-8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(12)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
        }
    }
    
    func endEdit() {
        self.commentTextView.resignFirstResponder()
    }
}
