//
//  SideMenuView.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/13.
//

import Foundation
import UIKit

class SideMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        createSubViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect.zero)

        let navItem = UINavigationItem()
        var img = UIImage(systemName: "xmark",
                          withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
        let navBarButton = UIBarButtonItem(image: img,
                                           style: .done,
                                           target: nil, // Added in SideMenuViewController
                                           action: nil) // Added in SideMenuViewController
        navBarButton.tintColor = .gray

        navItem.leftBarButtonItem = navBarButton
        navBar.items = [navItem]
        navBar.barTintColor = .white
        // code for eraseing the border
        navBar.shadowImage = UIImage()
        navBar.layoutIfNeeded()

        return navBar
    }()

    let profileImgButton: UIButton = {
        let button = UIButton()

        let targetSize = CGSize(width: 100, height: 100)
        var img = UIImage(systemName: "person.crop.circle")?.withTintColor(.lightGray)
        img = img?.scalePreservingAspectRatio(targetSize: targetSize)
        button.setImage(img, for: .normal)

        return button
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = """
                Sign up to upvote the best content,
                customize your feed, share your interests,
                and more!
                """
        label.font = UIFont(name: "Kailasa", size: 14)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0

        return label
    }()

    let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .blue

        return tableView
    }()

    private func createSubViews() {
        self.addSubview(navBar)
        self.addSubview(label)
        self.addSubview(profileImgButton)
        self.addSubview(menuTableView)

        NSLayoutConstraint.activateOneWayContraint(subView: navBar,
                                                   containerViewLayoutGuide: self.safeAreaLayoutGuide,
                                                   way: .top,
                                                   constant: 0)
        NSLayoutConstraint.activateTwoWayContraints(subView: navBar,
                                                    containerView: self,
                                                    widthMultiply: 1,
                                                    heightMultiply: 0.2)

        NSLayoutConstraint.activateTwoWayContraints(subView: profileImgButton,
                                                    containerView: self,
                                                    top: 100.0,
                                                    centerX: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: profileImgButton,
                                                   containerView: self,
                                                   way: .leading,
                                                   constant: 10.0)

        NSLayoutConstraint.activateTwoWayContraints(subView: label,
                                                    containerView: self,
                                                    widthMultiply: 1,
                                                    heightMultiply: 0.1)
        NSLayoutConstraint.activateOneWayContraint(targetView: label,
                                                   basisView: profileImgButton,
                                                   way: .top,
                                                   constant: 10)

        NSLayoutConstraint.activateOneWayContraint(targetView: menuTableView, basisView: label, way: .top, constant: 5)
        NSLayoutConstraint.activateTwoWayContraints(subView: menuTableView, containerView: self, widthMultiply: 1, heightMultiply: 0.7)
        menuTableView.backgroundColor = .cyan

        do {
            try NSLayoutConstraint.activateOneWayContraint(targetView: menuTableView,
                                                       basisView: self, axis: .horizontal,
                                                       constant: 0)
        } catch let error {
            let error = error as? CustomConstraintsError
            fatalError(error?.getMessage() ?? "constraints error")
        }
    }
}
