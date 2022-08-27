//
//  GalleryPostListViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GalleryPostListViewController: UIViewController {
    var viewModel: GalleryPostListViewModel?
    private let disposeBag = DisposeBag()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GalleryPostListTableViewCell.self, forCellReuseIdentifier: GalleryPostListTableViewCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
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
        view.addSubview(tableView)
    }
    
    private func configureUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setAttribute() {
        view.backgroundColor = .systemBackground
    }
}
