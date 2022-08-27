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
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ -> Void in return Void() }
            .asDriver(onErrorDriveWith: .empty())
        
        let input = GalleryPostListViewModel.Input(trigger: viewWillAppear, selection: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel?.transform(from: input)
        
        output?.postLists.drive(tableView.rx.items(cellIdentifier: GalleryPostListTableViewCell.reuseID, cellType: GalleryPostListTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }
        .disposed(by: disposeBag)
        
        output?.selectedPost.drive()
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposeBag)
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
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        
    }
}
