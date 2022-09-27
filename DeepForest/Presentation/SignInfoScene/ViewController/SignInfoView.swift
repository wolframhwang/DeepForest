//
//  SignInfoView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/27.
//

import Foundation
import UIKit
import FlexLayout
import PinLayout

class SignInfoView: UIView {
    lazy var scrollView = UIScrollView()
    private let rootFlexView = UIView()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "아이디"
        label.textColor = .gray
        
        return label
    }()
    
    let userNameContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = "닉네임"
        
        return label
    }()
    
    let nickNameContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .gray
        label.text = "이메일"
        
        return label
    }()
    
    let emailContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let signOffButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemBackground
        let safe = pin.safeArea
        
        scrollView.pin.all(safe)
        rootFlexView.pin.top().left().right()
        
        rootFlexView.flex.layout(mode: .adjustHeight)
        
        scrollView.contentSize = rootFlexView.frame.size
    }
}

extension SignInfoView {
    func setLayout() {
        setNeedsLayout()
    }
    
    func configureLayout() {
        rootFlexView.flex.define { flex in
            flex.addItem(userNameLabel)
                .marginTop(20)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(10)
            
            flex.addItem(userNameContent)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(30)
            
            flex.addItem(nickNameLabel)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(10)
            
            flex.addItem(nickNameContent)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(30)
            
            flex.addItem(emailLabel)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(10)
            
            flex.addItem(emailContent)
                .marginLeft(15)
                .marginRight(10)
                .marginBottom(30)
            
            flex.addItem(signOffButton)
                .height(56)
                .marginLeft(10)
                .marginRight(10)
        }
        
        scrollView.addSubview(rootFlexView)
        
        addSubview(scrollView)
    }
}
