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
        tableView.separatorStyle = .none
        tableView.register(GalleryPostListTableViewCell.self, forCellReuseIdentifier: GalleryPostListTableViewCell.reuseID)
        
        
        return tableView
    }()
    
    private lazy var writePostButton: UIButton = {
        let button = UIButton()
        button.setTitle(" ✏️ 글 쓰기 ", for: .normal)
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.6
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        return button
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
        
        let input = GalleryPostListViewModel.Input(trigger: viewWillAppear, selection: tableView.rx.itemSelected.asDriver(), didTappWritePostButton: writePostButton.rx.tap.asDriver().throttle(.seconds(1), latest: true))
        
        let output = viewModel?.transform(from: input)
        
        output?.postLists.drive(tableView.rx.items(cellIdentifier: GalleryPostListTableViewCell.reuseID, cellType: GalleryPostListTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }
        .disposed(by: disposeBag)
        
        output?.selectedPost.drive()
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
    
    private func configureSubviews() {
        [tableView, writePostButton].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func configureUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        writePostButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64)
        }
    }
    
    private func setAttribute() {
        view.backgroundColor = .systemBackground
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        
    }
}
