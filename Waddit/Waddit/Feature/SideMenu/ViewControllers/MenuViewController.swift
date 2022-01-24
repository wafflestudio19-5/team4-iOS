//
//  MenuViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import UIKit


struct ScreenSize {
    static let screenWidth       = UIScreen.main.bounds.size.width
    static let screenHeight      = UIScreen.main.bounds.size.height
}

protocol MenuViewControllerDelegete: AnyObject {
    func didTapCancelButton()
}

class MenuViewController: UIViewController {
    weak var delegate: MenuViewControllerDelegete?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.height)
        let rect = CGRect(x: 0, y: 0, width: ScreenSize.screenWidth - 100, height: ScreenSize.screenHeight)
        print(ScreenSize.screenHeight)
        
        self.view = SideMenuView(frame: rect)
        // Do any additional setup after loading the view.
        
    }
    
    @objc
    func didTabCancelButton() {
        delegate?.didTapCancelButton()
    }
}
