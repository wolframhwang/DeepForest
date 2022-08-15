//
//  MenuViewModel.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/14.
//

import Foundation
import RxSwift
import RxCocoa

final class MenuViewModel: ViewModelType {
    private weak var coordinator: MenuCoordinator?
    let disposeBag = DisposeBag()
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        //let crateMenu: Driver<Void>
        let menus: Driver<[MenuTableCellViewModel]>
        let selectedMenu: Driver<MenuTableCellViewModel>
    }
    
    init(coordinator: MenuCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(from input: Input) -> Output {
        let menus = Observable<[MenuItem]>.create { observe in
            observe.onNext([
                MenuItem(title: "메이저 갤러리", type: .galleryList),
                MenuItem(title: "마이너 갤러리", type: .galleryList),
                MenuItem(title: "미니 갤러리", type: .galleryList)
            ])
            observe.onCompleted()
            return Disposables.create()
        }
        .asDriver(onErrorJustReturn: [])
        .map {
            $0.map { item in
                MenuTableCellViewModel(with: item)
            }
        }
        
        let selectedMenu = input.selection
            .withLatestFrom(menus) { (indexPath, menus) -> MenuTableCellViewModel in
                return menus[indexPath.row]
            }
            .do(onNext: { [weak self] viewModel in
                self?.coordinator?.pushGalleryListViewController(menuTableCellViewModel: viewModel)
            })
        
        return Output(menus: menus, selectedMenu: selectedMenu)
    }
    
}
