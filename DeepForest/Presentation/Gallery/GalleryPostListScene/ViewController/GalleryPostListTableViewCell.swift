//
//  GalleryPostListTableViewCell.swift
//  DeepForest
//
//  Created by 황지웅 on 2022/08/22.
//

import UIKit
import SnapKit

class GalleryPostListTableViewCell: UITableViewCell {
    private lazy var mainStackView = UIStackView()
    private lazy var uiView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var layerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        return label
    }()
    
    private lazy var nickname: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .ultraLight)
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var createAt: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        label.textColor = .lightGray
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("GalleryPost Cell Error")
    }
    
    private func countLabelAttribute() {
        let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        guard let countLabelText = countLabel.text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: countLabelText)
        attributedString.addAttribute(.font, value: font, range: (countLabelText as NSString).range(of: "추천"))
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.gray,
                                      range: (countLabelText as NSString).range(of: "추천"))
        attributedString.addAttribute(.font, value: font, range: (countLabelText as NSString).range(of: "조회"))
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.gray,
                                      range: (countLabelText as NSString).range(of: "조회"))
        
        countLabel.attributedText = attributedString
    }
    
    func bind(_ galleryPostListCellViewModel: GalleryPostListCellViewModel) {
        titleLabel.text = galleryPostListCellViewModel.title + " [\(galleryPostListCellViewModel.commentCount)]"
        nickname.text = galleryPostListCellViewModel.writer
        countLabel.text = "| 추천 \(galleryPostListCellViewModel.likeCount) | 조회 \(galleryPostListCellViewModel.viewCount) |"
        countLabelAttribute()
        let createdTime = galleryPostListCellViewModel.createdAt.components(separatedBy: " ")
        let times = createdTime[1].components(separatedBy: ":")
        
        createAt.text = "\(createdTime[0] + " " + times[0] + ":" + times[1])"
    }

    private func configureSubviews() {
        //addSubview(uiView)
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(uiView)
        uiView.addSubview(stackView)
        
        [titleLabel, nickname, layerStackView].forEach { subview in
            stackView.addArrangedSubview(subview)
        }
                
        [countLabel, createAt].forEach { subview in
            layerStackView.addArrangedSubview(subview)
        }
    }
    
    private func configureUI() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview().inset(15)
        }

    }
}
