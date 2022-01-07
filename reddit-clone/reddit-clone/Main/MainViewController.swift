//
//  ViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = Optional(self)
    }
}

// showing community choice page
extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: PostCreationViewController.self) {
            let navCtrl = UINavigationController(rootViewController: PostToCommunityViewController())
            navCtrl.modalPresentationStyle = .fullScreen
            self.present(navCtrl, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

