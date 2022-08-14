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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
