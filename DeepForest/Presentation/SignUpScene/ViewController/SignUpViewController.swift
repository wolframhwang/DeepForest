//
//  SignUpViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/13.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    private var disposeBag = DisposeBag()
    var viewModel: SignUpViewModel?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.text = "아이디"
        
        return idLabel
    }()
    
    private lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "ID를 입력해주세요"
        tf.tag = 1
        
        return tf
    }()
    
    private lazy var idConstraint: UILabel = {
        let idConstraint = UILabel()
        idConstraint.text = "5자 ~ 20자 영문, 숫자로 입력해주세요."
        idConstraint.textColor = UIColor.systemGray
        idConstraint.font = UIFont.systemFont(ofSize: 10)
        
        return idConstraint
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.text = "닉네임"
        
        return nickNameLabel
    }()
    
    private lazy var nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "닉네임을 입력해주세요"
        tf.tag = 2
        
        return tf
    }()
    
    private lazy var nickNameConstraint: UILabel = {
        let nickNameConstraint = UILabel()
        nickNameConstraint.text = "20자 내외로 닉네임 입력해주세요! :)"
        nickNameConstraint.textColor = UIColor.systemGray
        nickNameConstraint.font = UIFont.systemFont(ofSize: 10)
        
        return nickNameConstraint
    }()
    
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.text = "비밀번호"
        
        return passwordLabel
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.isSecureTextEntry = true
        tf.tag = 3
        
        return tf
    }()
    
    private lazy var rePasswordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "비밀번호를 한번 더 확인 해주세요"
        tf.isSecureTextEntry = true
        tf.tag = 4
        
        return tf
    }()
    
    private lazy var passwordConstraint: UILabel = {
        let passwordConstraint = UILabel()
        passwordConstraint.text = "영문, 숫자 8~20자 내외로 해주세요"
        passwordConstraint.textColor = UIColor.systemGray
        passwordConstraint.font = UIFont.systemFont(ofSize: 8)
        
        return passwordConstraint
    }()
    
    private lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "이메일"
        
        return emailLabel
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "이메일을 입력해주세요."
        tf.tag = 5
        
        return tf
    }()
    
    private lazy var emailConstraint: UILabel = {
        let emailConstraint = UILabel()
        emailConstraint.text = "이메일을 넣어주세요!"
        emailConstraint.textColor = UIColor.systemGray
        emailConstraint.font = UIFont.systemFont(ofSize: 8)
        
        return emailConstraint
    }()
    
    private lazy var submitButton: UIButton = {
        let signUpButton = UIButton()
        
        signUpButton.setTitle("가입하기", for: .normal)
        //signUpButton.layer.opacity = 0
        signUpButton.backgroundColor = UIColor.systemBlue
        signUpButton.titleLabel?.textColor = .white
        signUpButton.layer.cornerRadius = 8
        
        return signUpButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        bindViewModel()
    }
    
}

extension SignUpViewController {
    private func bindViewModel() {
        
    }
    
    private func configureSubviews() {
        [idLabel, idTextField, idConstraint,
         nickNameLabel, nickNameTextField, nickNameConstraint,
         passwordLabel ,passwordTextField, rePasswordTextField, passwordConstraint,
         emailLabel ,emailTextField, emailConstraint,
         submitButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
                
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        idConstraint.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(idConstraint.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickNameConstraint.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameConstraint.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordConstraint.snp.makeConstraints {
            $0.top.equalTo(rePasswordTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(passwordConstraint.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailConstraint.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        submitButton.snp.makeConstraints {
            $0.top.equalTo(emailConstraint.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

    }
}
