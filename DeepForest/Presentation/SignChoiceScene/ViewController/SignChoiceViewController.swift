//
//  SignChoiceViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignChoiceViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: SignChoiceViewModel?
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.tintColor = .black
        signInButton.backgroundColor = .gray
        signInButton.setTitle("로그인", for: .normal)
        
        return signInButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.tintColor = .white
        signUpButton.backgroundColor = .green
        signUpButton.setTitle("회원가입", for: .normal)
                
        return signUpButton
    }()
    
    private lazy var noSignJoinButton: UIButton = {
        let noSignJoinButton = UIButton()
        noSignJoinButton.tintColor = .green
        noSignJoinButton.backgroundColor = .white
        noSignJoinButton.setTitle("비회원 로그인", for: .normal)
        
        return noSignJoinButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
        configureUI()
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    
}

extension SignChoiceViewController {
    func configureSubViews() {
        view.addSubview(buttonStackView)
        buttonStackView.addSubview(signInButton)
        buttonStackView.addSubview(signUpButton)
        buttonStackView.addSubview(noSignJoinButton)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
        
        noSignJoinButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let input = SignChoiceViewModel.Input(signInButtonDidTapEvent: signInButton.rx.tap.asObservable(),
                                              signUpButtonDidTapEvent: signUpButton.rx.tap.asObservable(),
                                              noSignJoinButtonDidTapEvent: noSignJoinButton.rx.tap.asObservable())
        
        let output = self.viewModel?.transform(from: input)
    }
    
}

extension SignChoiceViewController {
    
}
