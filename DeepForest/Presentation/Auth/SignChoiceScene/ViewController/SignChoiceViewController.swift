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
    
    private lazy var sceneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        label.textAlignment = .right
        label.text = "Deep Forest"
        
        return label
    }()
    
    private lazy var commyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.text = "Community App"
        
        return label
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
        signUpButton.backgroundColor = .systemIndigo
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.layer.cornerRadius = 5
        
        return signUpButton
    }()
    
    private lazy var noSignJoinButton: UIButton = {
        let noSignJoinButton = UIButton()
        noSignJoinButton.setTitleColor(UIColor.lightGray, for: .normal)
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
        [sceneLabel, commyLabel, signInButton, signUpButton, noSignJoinButton]
            .forEach { views in
                view.addSubview(views)
            }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        noSignJoinButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(noSignJoinButton.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(40)
        }
        
        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview().inset(22)
            make.height.equalTo(40)
        }
        
        sceneLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-22)
            make.centerY.equalToSuperview().offset(-120)
        }
        
        commyLabel.snp.makeConstraints { make in
            make.top.equalTo(sceneLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(22)
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
