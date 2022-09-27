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
import FlexLayout
import PinLayout

class SignInfoViewController: UIViewController {
    var viewModel: SignInfoViewModel?
    private let disposeBag = DisposeBag()
    
    private var mainView = SignInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SignInfo Scene"
        configureSubViews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
    
    override func loadView() {
        view = mainView
    }
}

extension SignInfoViewController {
    func bindViewModel() {
        let input = SignInfoViewModel.Input(tapSignOffbutton: mainView.signOffButton.rx.tap.asObservable())
        
        guard let output = viewModel?.transform(from: input) else { return }
        
        Driver.combineLatest(output.userName, output.nickName, output.email).drive(onNext: { [weak self] userName, nickName, email in
            self?.mainView.userNameContent.text = userName
            self?.mainView.nickNameContent.text = nickName
            self?.mainView.emailContent.text = email
            
            self?.mainView.userNameContent.flex.markDirty()
            self?.mainView.nickNameContent.flex.markDirty()
            self?.mainView.emailContent.flex.markDirty()
            
            self?.mainView.setLayout()
        })
        .disposed(by: disposeBag)
        
        
        output.titleContent.drive(onNext: { [weak self] title in
            self?.title = title
        }).disposed(by: disposeBag)
    }
    
    func configureSubViews() {
    }
    
    func configureUI() {
    }
    
    func setAttribute() {
        view.backgroundColor = .systemBackground
    }
}
