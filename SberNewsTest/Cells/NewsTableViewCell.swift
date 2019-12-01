//
//  NewsTableViewCell.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 29.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.contentMode = .scaleAspectFit
        return iconImage
    }()
    
    let lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.textColor = .black
        lblTitle.numberOfLines = 0
        lblTitle.textAlignment = .left
        lblTitle.font = UIFont(name: "ArialMT", size: 15)
        return lblTitle
    }()
    
    let lblAlreadySeen: UILabel = {
        let lblAlreadySeen = UILabel()
        lblAlreadySeen.textColor = .gray
        lblAlreadySeen.numberOfLines = 1
        lblAlreadySeen.textAlignment = .right
        lblAlreadySeen.font = UIFont(name: "ArialMT", size: 10)
        return lblAlreadySeen
    }()
    
    var viewModel: NewsTableViewModel? {
        
        didSet {
            guard let viewModel = viewModel else { return }
            self.viewModel = viewModel
            
            lblTitle.text = viewModel.lblTitle
            lblAlreadySeen.text = viewModel.lblAlreadySeen
            lblAlreadySeen.isHidden = !viewModel.isAlreadySeen
            iconImage.downloadedFrom(link: viewModel.image)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createConstraints()
    }
    
    func createConstraints() {
        self.add(views: lblTitle, iconImage, lblAlreadySeen)
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(102)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(90)
            make.height.equalTo(45)
        }
        
        lblAlreadySeen.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.width.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }
}
