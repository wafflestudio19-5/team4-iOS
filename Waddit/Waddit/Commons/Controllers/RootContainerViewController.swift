//
//  RootContainerViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import UIKit

class RootContainerViewController: UIViewController {

    enum MenuState {
        case opened
        case closed
    }

    private var menuState: MenuState = .closed

    let tabBarVC = TabBarController()
    let menuVC = MenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVCs()
        // Do any additional setup after loading the view.
    }

    private func addChildVCs() {
        // ad menuVC
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        // TODO: Add delegate

        // add tabBar VC
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)
        (tabBarVC.tabOne.rootViewController as? BaseTabViewController)?.delegate = self
        (tabBarVC.tabTwo.rootViewController as? BaseTabViewController)?.delegate = self
    }
}

extension RootContainerViewController: BaseTabViewControllerDelegate {
    func didTapMenu() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut) {
                self.tabBarVC.view.frame.origin.x = self.menuVC.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut) {
                self.tabBarVC.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                }
            }
        }
    }
}
