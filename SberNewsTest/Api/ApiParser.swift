//
//  ApiParser.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 29.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApiParser: NSObject {
    
    static let shared = ApiParser()
    
    func parseNews(json: JSON, completion: @escaping SuccessNews) {
        var news = [News]()
        
        let arrayNews = json["articles"].arrayValue
        
        for new in arrayNews {
            var modelNews = News()
            modelNews.titleNews = new["title"].string
            modelNews.descriptionNews = new["description"].string
            modelNews.publishedAtNews = new["publishedAt"].string
            modelNews.urlNews = new["url"].string
            modelNews.urlToImageNews = new["urlToImage"].string
            news.append(modelNews)
        }
        
        completion(true, nil, news)
    }
}
