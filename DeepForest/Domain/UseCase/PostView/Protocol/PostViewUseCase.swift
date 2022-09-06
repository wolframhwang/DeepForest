//
//  PostViewUseCase.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/06.
//

import Foundation
import RxSwift

protocol PostViewUseCase {
    func fetchPost() -> Observable<String?>
}
