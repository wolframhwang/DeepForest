//
//  MainSceneViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeSceneViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: HomeSceneViewModel?
    
    private lazy var sideMenuButton: UIBarButtonItem = {
        let menuButton = UIBarButtonItem()
        menuButton.style = .done
        menuButton.image = UIImage(systemName: "line.horizontal.3")
        
        return menuButton
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureUI()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
}

extension HomeSceneViewController {
    func configureSubviews() {
        navigationItem.leftBarButtonItem = sideMenuButton
        
        view.addSubview(tableView)
    }
    
    func configureUI() {
        title = "DEEP FOREST"
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        let input = HomeSceneViewModel.Input(menuButtonTapped: sideMenuButton.rx.tap.throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance).asObservable())
        let output = viewModel?.transform(from: input)
    }
}
