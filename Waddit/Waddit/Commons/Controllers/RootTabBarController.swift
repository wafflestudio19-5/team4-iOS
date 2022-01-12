//
//  RootTabBarController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let tabOne = UINavigationController(rootViewController: BaseFeedViewController())
        tabOne.tabBarItem = UITabBarItem(title: "Base", image: UIImage(systemName: "house.fill"), tag: 0)

        let tabTwo = UINavigationController(rootViewController: SubscriptionFeedViewController())
        tabTwo.tabBarItem = UITabBarItem(title: "Subscript", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        let tabThree = UINavigationController(rootViewController: CreatePostViewController())
        tabThree.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)

        self.viewControllers = [tabOne, tabTwo, tabThree]
        self.tabBar.backgroundColor = .white


    }
}
