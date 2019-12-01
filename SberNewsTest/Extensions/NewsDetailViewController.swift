//
//  NewsDetailViewController.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit
import SnapKit

class NewsDetailViewController: UIViewController {
    
    let iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.contentMode = .scaleToFill
        iconImage.image = UIImage(named: "no_photo")
        return iconImage
    }()

    let lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.textColor = .black
        lblTitle.numberOfLines = 0
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.font = UIFont(name: "ArialMT", size: 20)
        return lblTitle
    }()
    
    let lblDescription: UILabel = {
        let lblDescription = UILabel()
        lblDescription.textColor = .black
        lblDescription.numberOfLines = 0
        lblDescription.adjustsFontSizeToFitWidth = true
        lblDescription.font = UIFont(name: "ArialMT", size: 15)
        return lblDescription
    }()
    
    let lblUrl: UILabel = {
        let lblUrl = UILabel()
        lblUrl.textColor = .blue
        lblUrl.numberOfLines = 0
        lblUrl.textAlignment = .left
        lblUrl.font = UIFont(name: "ArialMT", size: 13)
        return lblUrl
    }()
    
    let lblPublishedAt: UILabel = {
        let lblPublishedAt = UILabel()
        lblPublishedAt.textColor = .gray
        lblPublishedAt.numberOfLines = 0
        lblPublishedAt.textAlignment = .left
        lblPublishedAt.font = UIFont(name: "ArialMT", size: 13)
        return lblPublishedAt
    }()
    
    let viewModel: NewsDetailViewModel
    
    init(_ viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel

        iconImage.downloadedFrom(link: viewModel.detailNews.urlToImageNews ?? "")
        lblTitle.text = viewModel.detailNews.titleNews
        lblDescription.text = viewModel.detailNews.descriptionNews
        lblUrl.text = viewModel.detailNews.urlNews
        
        let dateFormat = DateFormat.shared.convertDateToString(viewModel.detailNews.publishedAtNews)
        lblPublishedAt.text = dateFormat
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createConstraints()
        
    }
    
    func createConstraints() {
        view.add(views: iconImage, lblTitle, lblDescription, lblUrl, lblPublishedAt)
        
        iconImage.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(100)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(iconImage.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(26)
            make.right.equalToSuperview().inset(26)
            make.centerX.equalToSuperview()
        }
        
        lblDescription.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        lblUrl.snp.makeConstraints { (make) in
            make.top.equalTo(lblDescription.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        lblPublishedAt.snp.makeConstraints { (make) in
            make.top.equalTo(lblUrl.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }

    }

}
