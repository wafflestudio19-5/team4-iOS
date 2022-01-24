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
        
        setStyleForView()
        setLayoutForView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImgButton: UIButton = {
        let button = UIButton()
        
        let targetSize = CGSize(width: 100, height: 100)
        var img = UIImage(systemName: "person.crop.circle")
        img = img?.scalePreservingAspectRatio(targetSize: targetSize)
        button.setImage(img, for: .normal)

        return button
    }()
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .blue

        return tableView
    }()

    let navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect.zero)

        let navItem = UINavigationItem()
        var img = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .light))
        let navBarButton = UIBarButtonItem(image: img,
                                           style: .done,
                                           target: nil, // Added in NavBarViewController
                                           action: nil) // Added in NavBarViewController
        navBarButton.tintColor = .gray

        navItem.leftBarButtonItem = navBarButton
        navBar.items = [navItem]
        navBar.barTintColor = .white
        // code for eraseing the border
        navBar.shadowImage = UIImage()
        navBar.layoutIfNeeded()


        return navBar
    }()

    private func setStyleForView() {
    }

    private func setLayoutForView() {
        self.addSubview(navBar)
        self.addSubview(profileImgButton)
        self.addSubview(menuTableView)

        NSLayoutConstraint.activateOneWayContraint(subView: navBar,
                                                   containerViewLayoutGuide: self.safeAreaLayoutGuide,
                                                   way: .top,
                                                   constant: 0)
        NSLayoutConstraint.activateTwoWayContraints(subView: navBar, containerView: self, widthMultiply: 1, heightMultiply: 0.2)


        NSLayoutConstraint.activateTwoWayContraints(subView: profileImgButton, containerView: self, top: 100.0, centerX: 0)
        NSLayoutConstraint.activateOneWayContraint(subView: profileImgButton, containerView: self, way: .leading, constant: 10.0)

        NSLayoutConstraint.activateOneWayContraint(targetView: menuTableView, basisView: profileImgButton, way: .top, constant: 20.0)
    }
}
