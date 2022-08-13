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
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .green
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        bindViewModel()
    }
    
    private func configureSubviews() {
        [idTextField, pwTextField, submitButton].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    private func bindViewModel() {
        let input = SignInViewModel.Input(idObserverable: self.idTextField.rx.text.orEmpty.asObservable(),
                                          pwObservable: self.pwTextField.rx.text.orEmpty.asObservable(),
                                          buttonTapObservable: self.submitButton.rx.tap.asObservable())
        
        let output = viewModel?.transform(from: input)
    }
}
