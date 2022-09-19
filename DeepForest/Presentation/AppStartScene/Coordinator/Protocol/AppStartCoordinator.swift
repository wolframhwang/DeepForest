//
//  AppStartCoordinator.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/20.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

protocol AppStartCoordinator: Coordinator {
    func finishWithSign(with success: Bool)
}
