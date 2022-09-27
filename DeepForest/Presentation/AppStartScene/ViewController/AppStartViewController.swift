//
//  AppStartViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class AppStartViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: AppStartViewModel?
    
    private let sceneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        label.textAlignment = .right
        label.text = "Deep Forest"
        
        return label
    }()
    
    private let commyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        label.text = "Community App"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        bindViewModel()
    }
}

extension AppStartViewController {
    func configureSubviews() {
        [sceneLabel, commyLabel]
            .forEach { subView in
                view.addSubview(subView)
            }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
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
            .map { _ in }
        
        let input = AppStartViewModel.Input(trigger: trigger)
        
        let output = self.viewModel?.transforming(from: input, disposeBag: disposeBag)        
    }
}

