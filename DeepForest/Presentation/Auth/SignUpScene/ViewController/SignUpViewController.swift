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
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    private lazy var directionView = UIView()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.contentMode = .scaleToFill
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
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
        idConstraint.font = UIFont.systemFont(ofSize: 15)
        
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
        nickNameConstraint.font = UIFont.systemFont(ofSize: 15)
        
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
        passwordConstraint.font = UIFont.systemFont(ofSize: 15)
        
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
        emailConstraint.font = UIFont.systemFont(ofSize: 15)
        
        return emailConstraint
    }()
    
    private lazy var submitButton: UIButton = {
        let signUpButton = UIButton()
        
        signUpButton.setTitle("가입하기", for: .normal)
        //signUpButton.layer.opacity = 0
        signUpButton.backgroundColor = UIColor.systemIndigo
        signUpButton.titleLabel?.textColor = .white
        signUpButton.layer.cornerRadius = 8
        
        return signUpButton
    }()
    
    private lazy var separator1 = UIView()
    private lazy var separator2 = UIView()
    private lazy var separator3 = UIView()
    private lazy var separator4 = UIView()

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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )                
    }
    
    private func bindViewModel() {
        
        let input = SignUpViewModel.Input(idTextFieldDidEditEvent: idTextField.rx.text.orEmpty.asObservable(),
                                          nickNameTextFieldDidEditEvent: nickNameTextField.rx.text.orEmpty.asObservable(),
                                          pwTextFieldDidEditEvent: passwordTextField.rx.text.orEmpty.asObservable(),
                                          repwTextFieldDidEditEvent: rePasswordTextField.rx.text.orEmpty.asObservable(),
                                          emailTextFieldDidEditEvent: emailTextField.rx.text.orEmpty.asObservable(),
                                          submitButtonTapped: submitButton.rx.tap.asObservable()
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance),
                                          backButtonTapped: backButton.rx.tap.asObservable()
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
        view.addSubview(backButton)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [idLabel, idTextField, idConstraint, separator1,
         nickNameLabel, nickNameTextField, nickNameConstraint, separator2,
         passwordLabel ,passwordTextField, rePasswordTextField, passwordConstraint, separator3,
         emailLabel ,emailTextField, emailConstraint, separator4,
         submitButton].forEach {
            contentView.addArrangedSubview($0)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(56)
            $0.width.height.equalTo(45)
        }

        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(backButton.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width).inset(10)
            $0.leading.trailing.top.bottom.equalToSuperview()            .inset(10)
        }

        separator1.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        separator2.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        separator3.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        separator4.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        idTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
                
        nickNameTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        submitButton.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}
