//
//  CoreDataManager.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 29.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//
import CoreData
import UIKit

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: - Create entity from JSON
    func createEntity(json: News) -> NSManagedObject? {
        
        if let news = NSEntityDescription.insertNewObject(forEntityName: "NewsCoreData", into: context!) as? NewsCoreData {
            news.titleNews = json.titleNews
            news.descriptionNews = json.descriptionNews
            news.publishedAtNews = json.publishedAtNews
            news.urlNews = json.urlNews
            news.urlToImageNews = json.urlToImageNews
            return news
        }
        return nil
    }
    
    //MARK: - Save in CoreData
    func saveInCoreData(array: [News]) {
        _ = array.map{self.createEntity(json: $0)}
        do {
            try context?.save()
        } catch let error {
            print("Не получается сохранить. Ошибка - \(error)")
        }
    }
    
    func getAllArticles() -> [NewsCoreData] {
        return fetch(entityName: "NewsCoreData", predicate: nil)
    }
    
    func fetch<T>(entityName: String, predicate: NSPredicate?, sort: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsDistinctResults = true
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sort
            
        do {
            return try context?.fetch(fetchRequest) as! [T]
        } catch {
            fatalError()
        }
    }

    //MARK: - Delete
    func clearData() {
        do {
            let fetchRequest: NSFetchRequest<NewsCoreData> = NewsCoreData.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            do {
                try context?.execute(deleteRequest)
                
            } catch let error {
                print("Не получается удалить. Ошибка - \(error)")
            }
        }
    }
}
