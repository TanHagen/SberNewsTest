//
//  BaseRowViewModel.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 01.12.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

protocol RowViewModel {
    var cellClass: AnyClass { get set }
    var cellIdentifier: String { get set }
}

class BaseRowViewModel: RowViewModel {
    var cellClass: AnyClass
    var cellIdentifier: String
    
    init(_ cell: UITableViewCell.Type) {
        cellClass = cell
        cellIdentifier = cell.cellIdentifier()
    }
}
