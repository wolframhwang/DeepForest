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
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.setTitleColor(UIColor.black, for: .normal)
        signInButton.backgroundColor = .gray
        signInButton.setTitle("로그인", for: .normal)
        signInButton.layer.cornerRadius = 5
        
        return signInButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let signUpButton = UIButton()
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.backgroundColor = .green
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.layer.cornerRadius = 5
        
        return signUpButton
    }()
    
    private lazy var noSignJoinButton: UIButton = {
        let noSignJoinButton = UIButton()
        noSignJoinButton.setTitleColor(UIColor.green, for: .normal)
        noSignJoinButton.backgroundColor = .white
        noSignJoinButton.setTitle("비회원 로그인", for: .normal)
        noSignJoinButton.layer.cornerRadius = 5
        
        return noSignJoinButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureSubViews()
        configureUI()
        bindViewModel()
        //view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }
    
}

extension SignChoiceViewController {
    func configureSubViews() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(signUpButton)
        buttonStackView.addArrangedSubview(noSignJoinButton)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-80)
            
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
        let trigger = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }.asDriver(onErrorDriveWith: .empty())
        
        let input = SignChoiceViewModel.Input(trigger: trigger,
                                              signInButtonDidTapEvent: signInButton.rx.tap.asObservable(),
                                              signUpButtonDidTapEvent: signUpButton.rx.tap.asObservable(),
                                              noSignJoinButtonDidTapEvent: noSignJoinButton.rx.tap.asObservable())
        
        self.viewModel?.transform(from: input)
    }
    
}

extension SignChoiceViewController {
    
}
