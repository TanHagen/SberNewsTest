//
//  Array + Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 01.12.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
