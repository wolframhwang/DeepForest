//
//  GalleryListViewController.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import UIKit
import RxSwift

class GalleryListViewController: UIViewController {
    var viewModel: GalleryListViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Test Code
        view.backgroundColor = .red
    }
}
