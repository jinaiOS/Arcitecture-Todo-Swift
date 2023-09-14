//
//  CustomSideMenuNavigation.swift
//  TodoApp
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit
import SideMenu

class CustomSideMenuNavigation: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftSide = true
    }
    
}
