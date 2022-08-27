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
        tableView.register(GalleryListTableViewCell.self, forCellReuseIdentifier: GalleryListTableViewCell.reuseID)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Test Code
        configureSubviews()
        configureUI()
        setAttribute()
        bindViewModel()
    }
}

extension GalleryListViewController {
    func configureSubviews() {
        view.addSubview(tableView)
    }
    func configureUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func setAttribute() {
        view.backgroundColor = .systemBackground
    }
    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ -> Void in return Void() }
            .asDriver(onErrorDriveWith: .empty())
        
        let input = GalleryListViewModel.Input(trigger: viewWillAppear, selection: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel?.transform(from: input)
        
        output?.galleryLists.drive(tableView.rx.items(cellIdentifier: GalleryListTableViewCell.reuseID, cellType: GalleryListTableViewCell.self)) {
            tv, viewModel, cell in
            cell.bind(viewModel)
        }
        .disposed(by: disposeBag)
        
        output?.title.drive(onNext: { [weak self] title in
            self?.title = title
        })
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
