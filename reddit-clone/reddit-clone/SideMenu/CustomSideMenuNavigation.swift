//
//  CustomSideMenuNavigation.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/12/18.
//

import Foundation
import SideMenu

class CustomSideMenuNavigation: SideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftSide = true
        self.menuWidth = self.view.frame.width * 0.7
        
    }
}
