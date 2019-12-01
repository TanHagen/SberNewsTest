//
//  Alamofire+Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 29.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
