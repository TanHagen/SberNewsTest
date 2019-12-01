//
//  ApiManager.swift
//  SberNewsTest
//
//  Created by Anton Zaitcev on 29/11/2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias SuccessNews = (_ success: Bool, _ error: Error?, _ newsModel: [News]?) -> ()

class ApiManager: NSObject {
    
    static let shared = ApiManager()

    let key = "&apiKey=b59bc1f13f884301a259ebc4a7c68af2"
    let url = "https://newsapi.org/v2/everything?q="
    
    //https://newsapi.org/v2/everything?q=россия&apiKey=b59bc1f13f884301a259ebc4a7c68af2
    
    func getNews(request: String, completion: @escaping SuccessNews) {
        
        let cimpositeLink = ApiManager.shared.url + request + key
        print(cimpositeLink)
        
        manager.request(cimpositeLink, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        .debugLog()
        .validate()
        .responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                guard let value = response.result.value else {
                    return
                }
                
                let json = JSON(value)
                print(json)
                
                ApiParser.shared.parseNews(json: json, completion: { (success, error, news) in
                    completion(true, nil, news)
                })
                
            case .failure(let error):
                completion(false, error, nil)
                break
            }
        }
    }
    
    let manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
