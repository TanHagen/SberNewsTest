//
//  NewsDetailViewModel.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation

class NewsDetailViewModel {
    
    var detailNews = NewsCoreData()
    
    init(detailNews: NewsCoreData) {
        self.detailNews = detailNews
    }
    
    
}
