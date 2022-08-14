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
    private lazy var directionView = UIView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        return button
    }()
    
    private lazy var idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.text = "아이디"
        
        return idLabel
    }()
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    private lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "ID를 입력해주세요"
        tf.tag = 1
        tf.delegate = self
        
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
        tf.delegate = self
        
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
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var rePasswordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "비밀번호를 한번 더 확인 해주세요"
        tf.isSecureTextEntry = true
        tf.tag = 4
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var passwordConstraint: UILabel = {
        let passwordConstraint = UILabel()
        passwordConstraint.text = "영문, 숫자 8~20자 내외로 해주세요"
        passwordConstraint.textColor = UIColor.systemGray
        passwordConstraint.font = UIFont.systemFont(ofSize: 10)
        
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
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var emailConstraint: UILabel = {
        let emailConstraint = UILabel()
        emailConstraint.text = "이메일을 넣어주세요!"
        emailConstraint.textColor = UIColor.systemGray
        emailConstraint.font = UIFont.systemFont(ofSize: 10)
        
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
        setAttribute()
        bindViewModel()
    }
}

extension SignUpViewController {
    private func setAttribute() {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    private func bindViewModel() {
        
        let input = SignUpViewModel.Input(idTextFieldDidEditEvent: idTextField.rx.text.orEmpty.asObservable(),
                                          nickNameTextFieldDidEditEvent: nickNameTextField.rx.text.orEmpty.asObservable(),
                                          pwTextFieldDidEditEvent: passwordTextField.rx.text.orEmpty.asObservable(),
                                          repwTextFieldDidEditEvent: rePasswordTextField.rx.text.orEmpty.asObservable(),
                                          emailTextFieldDidEditEvent: emailTextField.rx.text.orEmpty.asObservable(),
                                          submitButtonTapped: submitButton.rx.tap.asObservable()
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance)
        )
        
        let output = viewModel?.transform(from: input)
        output?.userIdConstraintLabel.bind(to: idConstraint.rx.text)
            .disposed(by: disposeBag)
        
        output?.nickNameConstraintLabel.bind(to: nickNameConstraint.rx.text)
            .disposed(by: disposeBag)
        
        output?.passwordConstraintLabel.bind(to: passwordConstraint.rx.text)
            .disposed(by: disposeBag)
        
        output?.emailConstraintLabel.bind(to: emailConstraint.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    private func configureSubviews() {
        view.addSubview(directionView)
        directionView.addSubview(backButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [idLabel, idTextField, idConstraint,
         nickNameLabel, nickNameTextField, nickNameConstraint,
         passwordLabel ,passwordTextField, rePasswordTextField, passwordConstraint,
         emailLabel ,emailTextField, emailConstraint,
         submitButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        directionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.height.equalTo(directionView.snp.height)
        }
        
        scrollView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(0)
            $0.top.equalTo(directionView.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(0)
            $0.width.equalTo(view.frame.width)
            $0.height.equalTo(view.frame.height + 300)
        }

        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
