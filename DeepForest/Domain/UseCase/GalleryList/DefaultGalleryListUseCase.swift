//
//  DefaultGalleryListUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import Foundation
import RxSwift
import RxCocoa

final class DefaultGalleryListUseCase: GalleryListUseCase {
    private let networkRepository: NetworkRepository
    
    private let menuItem: MenuTableCellViewModel
    
    var title: Observable<String>
    
    init(networkRepository: NetworkRepository,
         menuItem: MenuTableCellViewModel) {
        self.networkRepository = networkRepository
        self.menuItem = menuItem
        self.title = Observable.just(menuItem.title)
    }
    
    func fetchGalleryList() -> Observable<[Gallery]> {
        guard let type = GalleryType.init(rawValue: menuItem.title) else {
            return Observable.error(UseCaseError.optionalBindingFail)
        }

        return networkRepository.fetch(urlSuffix: "/api/v1/galleries", queryItems: ["type": type.galleryType]).map { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(GalleryListResponseDTO.self, from: data)
                    if response.success {
                        guard let fetchResponse = response.result else {
                            return []
                        }
                        
                        return fetchResponse.map { dto ->Gallery in
                            return Gallery(galleryId: dto.id,
                                    galleryName: dto.name,
                                           type: dto.type.isGalleryType)
                        }
                    } else {
                        return []
                    }
                } catch {
                    return []
                }
            case .failure(let error):
                return []
            }
        }
    }
}
