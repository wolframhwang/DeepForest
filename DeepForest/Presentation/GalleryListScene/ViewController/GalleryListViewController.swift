//
//  GalleryListViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GalleryListViewController: UIViewController {
    var viewModel: GalleryListViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Test Code
        view.backgroundColor = .red
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension GalleryListViewController {
    func configureSubviews() {
        
    }
    func configureUI() {
        
    }
    func setAttribute() {
        
    }
    func bindViewModel() {
        
    }
}
