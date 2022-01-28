//
//  RootTabBarController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit


class TabBarController: UITabBarController {

    let tabOne = UINavigationController(rootViewController: BaseFeedViewController())
    let tabTwo = UINavigationController(rootViewController: SubscriptionFeedViewController())
    let tabThree = UINavigationController(rootViewController: CreatePostViewController())

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = Optional(self)
        setTabBarDesign()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabOne.tabBarItem = UITabBarItem(title: "Base", image: UIImage(systemName: "house.fill"), tag: 0)

        tabTwo.tabBarItem = UITabBarItem(title: "Subscript", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        tabThree.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)

        self.viewControllers = [tabOne, tabTwo, tabThree]

    }

    func setTabBarDesign() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowImage = nil
        appearance.shadowColor = nil

        tabBar.standardAppearance   = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .orange
    }
}

extension TabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {


        guard let vc = (viewController as? UINavigationController)?.rootViewController else { return true }

        if vc.isKind(of: CreatePostViewController.self) {
            let navCtrl = UINavigationController(rootViewController: ChooseCommunityViewController())
            navCtrl.modalPresentationStyle = .fullScreen
            self.present(navCtrl, animated: true, completion: nil)
            return false
        }
        return true
    }
}
