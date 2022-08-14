//
//  MenuViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class MenuViewController: UIViewController {
    private var disposeBag = DisposeBag()
    var viewModel: MenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension MenuViewController {
    func configureSubviews() {
        
    }
    func configureUI() {
        
    }
    func setAttribute() {
        
    }
    func bindViewModel() {
        
    }
}
