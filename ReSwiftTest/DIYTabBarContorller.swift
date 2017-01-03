//
//  DIYTabBarContorller.swift
//  ReSwiftTest
//
//  Created by Søren Nielsen on 03/01/2017.
//  Copyright © 2017 e-conomic International A/S. All rights reserved.
//

import Foundation
import UIKit

class DIYTabBarController: UITabBarController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let items = tabBar.items {
            for tabBarItem in items {
                tabBarItem.title = ""
                tabBarItem.imageInsets = UIEdgeInsetsMake(9, 0, -9, 0)
            }
        }
    }
}
