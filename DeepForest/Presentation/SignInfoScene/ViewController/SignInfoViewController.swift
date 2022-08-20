//
//  SignInfoViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SignInfoViewController: UIViewController {
    var viewModel: SignInfoViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var idInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var signOffButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignInfo Scene"
        configureSubViews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension SignInfoViewController {
    func bindViewModel() {
        let input = SignInfoViewModel.Input(tapSignOffbutton: signOffButton.rx.tap.asObservable())
        
        let output = viewModel?.transform(from: input)
        output?.idText.drive(idInfoLabel.rx.text).disposed(by: disposeBag)
        output?.titleContent.drive(onNext: { [weak self] title in
            self?.title = title
        }).disposed(by: disposeBag)
    }
    
    func configureSubViews() {
        [idInfoLabel, signOffButton].forEach {
            view.addSubview($0)
        }
    }
    
    func configureUI() {
        idInfoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        signOffButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(idInfoLabel.snp.bottom).offset(20)
        }
    }
    func setAttribute() {
        view.backgroundColor = .systemBackground
    }
}
