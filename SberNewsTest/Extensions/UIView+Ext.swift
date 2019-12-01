//
//  UIView + Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

extension UIView {
    
    func add(views: UIView...) {
        for i in views {
            self.addSubview(i)
        }
    }
}
