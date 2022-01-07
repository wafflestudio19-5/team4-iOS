//
//  ViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    @IBOutlet weak var storyboardTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = Optional(self)
        setTabBarIcons()
    }
    
    func setTabBarIcons() {
        if let tabBarItemHome = storyboardTabBar.items?[0] {
            tabBarItemHome.image = UIImage(systemName: "house.fill")
        }
        
        if let tabBarItemHome = tabBar.items?[1] {
            tabBarItemHome.image = UIImage(systemName: "eyglasses")
        }
        if let tabBarItemHome = tabBar.items?[2] {
            tabBarItemHome.image = UIImage(systemName: "plus")
        }
        if let tabBarItemHome = tabBar.items?[3] {
            tabBarItemHome.image = UIImage(systemName: "message.fill")
        }
        if let tabBarItemHome = tabBar.items?[4] {
            tabBarItemHome.image = UIImage(systemName: "bell")
        }
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

