//
//  SignInViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/07/28.
//

import UIKit
import RxSwift
import SnapKit

class SignInViewController: UIViewController {
    private var disposeBag = DisposeBag()
    var viewModel: SignInViewModel?
    
    private lazy var directionView = UIView()
    
    private lazy var signInSceneMessage: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.text = "Welcome\nSignInScene!"
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "아이디"
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 25)
        
        return textField
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "비밀번호"
        textField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 25)
        
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        //button.layer.borderWidth = 2
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        bindViewModel()
    }
    
    private func configureSubviews() {
        view.addSubview(directionView)
        directionView.addSubview(backButton)
        
        [signInSceneMessage ,idTextField, pwTextField, submitButton].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        directionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(41)
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(18)
        }
        
        signInSceneMessage.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(28)
            make.leading.equalTo(22)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(signInSceneMessage.snp.bottom).offset(22)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(15)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(62)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(22)
        }
    }
    
    private func bindViewModel() {
        let input = SignInViewModel.Input(idObserverable: self.idTextField.rx.text.orEmpty.asObservable(),
                                          pwObservable: self.pwTextField.rx.text.orEmpty.asObservable(),
                                          buttonTapObservable: self.submitButton.rx.tap.asObservable(),
                                          backButtonTapObservable: self.backButton.rx.tap.asObservable()
        )
        
        let output = viewModel?.transform(from: input)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
