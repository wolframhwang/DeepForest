//
//  PostContentView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/11.
//

import Foundation
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

/*
 View - ViewController - ViewModel
 
 */
class PostContentview: UIView {
    lazy var scrollView = UIScrollView()
    private let rootFlexView = UIView()
    
    let titleContentSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    let contentCommentSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    let writeInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    let write: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        
        return label
    }()
    
    let spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.sizeToFit()
        
        return label
    }()
    
    let commentView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Post View Fatal Error Occured")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemBackground
        // To-do: Layout 걸어줄거 확인
        let safe = pin.safeArea
        
        scrollView.pin.all(safe)
        rootFlexView.pin.top().left().right()
        
        rootFlexView.flex.layout(mode: .adjustHeight)

        scrollView.contentSize = rootFlexView.frame.size
    }
}

extension PostContentview {
    func setLayout() {
        setNeedsLayout()
        
    }
    
    func makeComment(_ comments: [CommentItem]) {
        for subview in commentView.subviews {
            subview.removeFromSuperview()
        }
        comments.forEach { item in
            commentView
                .flex
                .addItem(PostCommentView(commentItem: item))
            commentView
                .flex
                .addItem(BorderLineView())
                .height(1)
        }
    }
    
    func configureLayout() {
        rootFlexView.flex.define { flex in
            flex.addItem().define { subflex in
                subflex.addItem(titleLabel)
                subflex.addItem(write)
                subflex.addItem(date)
            }.marginLeft(10).marginRight(10)
                .marginBottom(10)
                .markDirty()
            
            flex.addItem(titleContentSeparator)
                .marginBottom(10)
                .height(1)
            
            flex.addItem(contentLabel)
                .marginLeft(10)
                .marginRight(10)
                .marginTop(10)
                .marginBottom(20)
            
            flex.addItem(spaceView)
                .height(80)
            
            flex.addItem(contentCommentSeparator)
                .height(1)
            
            flex.addItem(commentLabel)
                .paddingTop(10)
                .paddingBottom(10)
            
            flex.addItem(BorderLineView())
                .height(1)
            
            flex.addItem(commentView)
        }
        
        scrollView.addSubview(rootFlexView)
        
        addSubview(scrollView)
    }
    
}
