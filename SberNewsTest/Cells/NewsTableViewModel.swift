//
//  NewsTableViewModel.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewModel: BaseRowViewModel {
    
    var lblTitle: String
    var image: String
    var lblAlreadySeen: String = "Просмотрено!"
    var isAlreadySeen = false
    
    init(news: NewsCoreData) {
        
        self.lblTitle = news.titleNews ?? ""
        self.image = news.urlToImageNews ?? "no_photo"
        self.isAlreadySeen = news.isAlreadySeen
        
        super.init(NewsTableViewCell.self)
    }
}
