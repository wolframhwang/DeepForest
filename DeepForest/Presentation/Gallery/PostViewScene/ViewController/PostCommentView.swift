//
//  PostCommentView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/17.
//

import Foundation
import FlexLayout
import UIKit
import PinLayout
import RxSwift
import RxCocoa

class PostCommentView: UIView {
    private let rootFlexView = UIView()
    private let commentId = 0

    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        
        return label
    }()
    
    let writer: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .ultraLight)
        
        return label
    }()
    
    init(commentItem: CommentItem) {
        super.init(frame: .zero)
        setAttribute(commentItem)
        configureLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setAttribute(_ commentItem: CommentItem) {
        let nickname = NSMutableAttributedString(string: commentItem.nickName)
        self.writer.text = "\(commentItem.nickName)(\(commentItem.username))"
        self.contentLabel.text = commentItem.content
        self.date.text = commentItem.createdAt
        
        writer.flex.markDirty()
        contentLabel.flex.markDirty()
        date.flex.markDirty()
        
    }
    
    func configureLayout() {
        rootFlexView.flex.define { flex in
            flex.addItem(writer)
                .marginTop(5)
                .marginLeft(10).marginRight(10)
                .marginBottom(5)
            
            flex.addItem(contentLabel)
                .marginLeft(10).marginRight(10)
                .marginBottom(5)
            
            flex.addItem(date)
                .marginLeft(10).marginRight(10)
                .marginBottom(5)
        }
        
        addSubview(rootFlexView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemBackground
        
        rootFlexView.pin.top().left().right()
        rootFlexView.flex.layout(mode: .adjustHeight)
    }

}
