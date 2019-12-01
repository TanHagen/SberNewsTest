//
//  DateFormat.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation

class DateFormat {
    
    static let shared = DateFormat()
    
    func convertDateToString(_ string: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z"
        guard let string = string, let date = dateFormatter.date(from: string) else {
            return nil
        }
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
