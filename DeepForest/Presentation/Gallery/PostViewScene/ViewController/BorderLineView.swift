//
//  BorderLineView.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/09/17.
//

import Foundation
import UIKit

final class BorderLineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
