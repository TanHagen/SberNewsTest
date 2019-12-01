//
//  UINavigationController + Ext.swift
//  SberNewsTest
//
//  Created by Антон Зайцев on 30.11.2019.
//  Copyright © 2019 Anton Zaitcev. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var topBarHeight: CGFloat {
        return self.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
    }

}
