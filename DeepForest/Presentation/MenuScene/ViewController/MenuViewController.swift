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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
        
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

extension MenuViewController {
    func configureSubviews() {
        view.addSubview(tableView)
    }
    
    func configureUI() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAttribute() {
        
    }
    
    func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ -> Void in return Void() }
            .asDriver(onErrorDriveWith: .empty())
        
        let input = MenuViewModel.Input(trigger: viewWillAppear,
                                        selection: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel?.transform(from: input)
        output?.menus.drive(tableView.rx.items(cellIdentifier: MenuTableViewCell.reuseID, cellType: MenuTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
        }.disposed(by: disposeBag)
        
        output?.selectedMenu.drive()
            .disposed(by: disposeBag)
        
    }
}
