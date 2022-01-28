//
//  SlideTabViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/28.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class SlideTabViewController: TabmanViewController {

    let barView = UIView()

    private var viewControllers: [UIViewController] = {
        let popularSortVC = PopularSortFeedViewController()
        let latestSortVC  = LatestSortFeedViewController()
        let vcs = [popularSortVC, latestSortVC]

        return vcs
    }()

    // set file name at nibName


    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        addTabBarView()
        addViewController()

        view.isUserInteractionEnabled = true
    }

    func addTabBarView() {
        view.addSubview(barView)
        barView.backgroundColor = .white
        barView.anchor(.top(view.topAnchor, constant: 0),
                       .leading(view.leadingAnchor, constant: 0),
                       .trailing(view.trailingAnchor, constant: 0),
                       .height(40))
    }

    // MARK: - Add viewcontroller to custom tabBar
    func addViewController() {

        // MARK: - create bar
        let bar = TMBar.ButtonBar()
        barView.addSubview(bar)
        bar.backgroundView.style = .blur(style: .regular)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
        }
        bar.indicator.weight = .light
        bar.indicator.tintColor = .systemIndigo
        bar.indicator.overscrollBehavior = .compress
        addBar(bar, dataSource: self, at: .custom(view: barView, layout: nil))
    }
}

// MARK: - Code for custom tabBar
extension SlideTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "Popular")
        case 1:
            return TMBarItem(title: "Latest")
        default:
            return TMBarItem(title: "test")
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
