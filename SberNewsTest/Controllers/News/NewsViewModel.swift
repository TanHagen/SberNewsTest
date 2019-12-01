//
//  NewsViewModel.swift
//  SberNewsTest
//
//  Created by Anton Zaitcev on 29/11/2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit
import CoreData

class NewsViewModel {

    private let coreDataManager = CoreDataManager()
    
    var newsArray = [NewsCoreData]()
    
    var uniqueArray = [NewsCoreData]()
    
    init() {
        getNewsFromCoreData()
    }
    
    func makeNewsAlreadySeen(index: Int) {

        newsArray[index].isAlreadySeen = true

        do {
            try coreDataManager.context?.save()
        } catch {
            print(error.localizedDescription)
        }

    }
    
    func getNews(request: String, completion: @escaping SuccessNews) {
        
        ApiManager.shared.getNews(request: request) { [weak self] (success, error, news) in

            guard let self = self else { return }
            if success {
                if let news = news {
                    self.coreDataManager.saveInCoreData(array: news)
                    self.getNewsFromCoreData()
                } else {
                    return
                }
                completion(true, nil, news)
            } else {
                print("Неудачно")
                completion(false, error, nil)
            }
        }
    }
    
    func getNewsFromCoreData() {
        self.newsArray = coreDataManager.getAllArticles()
    }
    
}
