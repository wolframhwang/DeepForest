//
//  GalleryPostListViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class GalleryPostListViewController: UIViewController {
    var viewModel: GalleryPostListViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension GalleryPostListViewController {
    private func bindViewModel() {
        
    }
    
    private func configureSubviews() {
        
    }
    
    private func configureUI() {
        
    }
    
    private func setAttribute() {
        
    }
}
