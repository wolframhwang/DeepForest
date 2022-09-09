//
//  UIImage+.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/08.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
