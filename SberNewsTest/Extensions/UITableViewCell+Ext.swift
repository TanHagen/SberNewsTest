//
//  UITableViewCell+Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 01.12.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    func setSeparatorHidden(_ isHidden: Bool) {
        if isHidden {
            separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
        } else {
            separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
