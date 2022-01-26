//
//  RootTabBarController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {

    let tabOne = UINavigationController(rootViewController: BaseFeedViewController())
    let tabTwo = UINavigationController(rootViewController: SubscriptionFeedViewController())
    let tabThree = UINavigationController(rootViewController: CreatePostViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        tabOne.tabBarItem = UITabBarItem(title: "Base", image: UIImage(systemName: "house.fill"), tag: 0)

        tabTwo.tabBarItem = UITabBarItem(title: "Subscript", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        tabThree.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)

        self.viewControllers = [tabOne, tabTwo, tabThree]
        self.tabBar.backgroundColor = .white
    }
}
