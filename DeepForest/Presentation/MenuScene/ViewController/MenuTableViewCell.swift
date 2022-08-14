//
//  MenuTableViewCell.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(_ viewModel: MenuTableCellViewModel) {
        self.titleLabel.text = viewModel.title
    }
}
