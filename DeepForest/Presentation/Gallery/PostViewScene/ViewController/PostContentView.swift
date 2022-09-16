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
    private lazy var scrollView = UIScrollView()
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
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
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
                .marginLeft(10)
                .marginRight(10)
                .marginBottom(10)
                .height(3)
            
            flex.addItem(contentLabel)
                .marginLeft(10)
                .marginRight(10)
            
            flex.addItem(contentCommentSeparator)
                .marginLeft(10)
                .marginRight(10)
                .height(3)
        }
        
        scrollView.addSubview(rootFlexView)
        
        addSubview(scrollView)
    }
    
}
