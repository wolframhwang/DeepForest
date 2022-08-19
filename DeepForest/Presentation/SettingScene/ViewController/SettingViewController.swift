//
//  SettingViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/19.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SettingViewController: UIViewController {
    var viewModel: SettingViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
    
}

extension SettingViewController {
    func bindViewModel() {
        
    }
    
    func configureSubViews() {
        
    }
    
    func configureUI() {
        
    }
    
    func setAttribute() {
        
    }
}
