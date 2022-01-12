//
//  SideMenuView.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/13.
//

import Foundation
import UIKit

class SideMenuView: UIView {
    
    let profileImgButton: UIButton = {
        let button = UIButton()
        let img = UIImage(systemName: "Reddit_VerticalLockup_OnWhite")
        
        button.image = img
        
        return button
    }()
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
}
