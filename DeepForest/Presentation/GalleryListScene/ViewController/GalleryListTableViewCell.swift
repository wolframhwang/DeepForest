//
//  GalleryListTableViewCell.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/15.
//

import UIKit
import SnapKit

class GalleryListTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
                .inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryCell Error")
    }
    
    func bind(_ viewModel: GalleryListCellViewModel) {
        self.titleLabel.text = viewModel.name
    }

}
