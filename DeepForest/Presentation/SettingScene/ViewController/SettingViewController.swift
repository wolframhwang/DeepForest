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
import RxDataSources

final class SettingViewController: UIViewController {
    var viewModel: SettingViewModel?
    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SettingListCell.self, forCellReuseIdentifier: SettingListCell.reuseID)
        
        return tableView
    }()
    
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
        let configureCell: (TableViewSectionedDataSource<SectionModel<String, String>>,UITableView,IndexPath,String) -> UITableViewCell = {(dataSource, tableView, indexPath, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingListCell.reuseID, for: indexPath) as? SettingListCell else { return UITableViewCell() }
            cell.textLabel?.text = element
            return cell
        }
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>.init(configureCell: configureCell)
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        let input = SettingViewModel.Input(selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel?.transform(from: input)
        output?.settingItems.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
    
    func configureSubViews() {
        view.addSubview(tableView)
    }
    
    func configureUI() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setAttribute() {
        
    }
}
