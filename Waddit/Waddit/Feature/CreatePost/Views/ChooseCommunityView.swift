//
//  ChooseCommunityView.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/29.
//

import UIKit

class ChooseCommunityView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        createHeaderView()
        createMainView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect.zero)

        let navItem = UINavigationItem()
        var img = UIImage(systemName: "xmark",
                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light))
        let navBarCancelButton = UIBarButtonItem(image: img,
                                           style: .done,
                                           target: nil,
                                           action: nil)
        navBarCancelButton.tintColor = .gray


        navItem.leftBarButtonItem = navBarCancelButton

        navItem.title = "Post To"

        navBar.items = [navItem]

        // iOS navbar against scrolling
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .white
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance

        return navBar
    }()

    let communityListView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .blue

        return tableView
    }()

    let seeMoreButton: UIButton = {
        let button = UIButton(title: "See All",
                              titleColor: UIColor(named: "RedditDarkBlue") ?? .systemPurple,
                              font: .boldSystemFont(ofSize: 18),
                              radius: 20, target: nil, action: nil)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "RedditDarkBlue")?.cgColor

        return button
    }()

    let mainContainerView = UIView()


    func createHeaderView() {
        self.addSubview(navBar)
        navBar.sizeToFit()

        if let targetView = navBar.topItem?.titleView {
            NSLayoutConstraint.activateOneWayContraint(targetView: targetView, sizeWay: .width, constant: 70)
        }
        NSLayoutConstraint.activateOneWayContraint(subView: navBar,
                                                   containerViewLayoutGuide: self.safeAreaLayoutGuide,
                                                   way: .top,
                                                   constant: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: navBar, containerView: self, way: .leading, constant: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: navBar, containerView: self, way: .trailing, constant: 0)

    }

    func createMainView() {
        mainContainerView.addSubview(communityListView)
        mainContainerView.addSubview(seeMoreButton.withHeight(40))
        self.addSubview(mainContainerView)

        communityListView.anchor(.top(navBar.bottomAnchor, constant: 10))
        NSLayoutConstraint.activateTwoWayContraints(subView: communityListView, containerView: mainContainerView, widthMultiply: 1, heightMultiply: 0.6)

        seeMoreButton.anchor(.top(communityListView.bottomAnchor, constant: 5))
        seeMoreButton.fillSuperviewWidth()

        mainContainerView.anchor(.top(navBar.bottomAnchor, constant: 10),
                                 .leading(self.leadingAnchor, constant: 10),
                                 .trailing(self.trailingAnchor, constant: 10),
                                 .bottom(self.bottomAnchor, constant: 5))

    }

}
