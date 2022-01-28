//
//  MenuViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import UIKit
import RxSwift


struct ScreenSize {
    static let screenWidth       = UIScreen.main.bounds.size.width
    static let screenHeight      = UIScreen.main.bounds.size.height
}

protocol MenuViewControllerDelegete: AnyObject {
    func didTapCancelButton()
    func didSelect(menuItem: MenuOptions)
}

class SideMenuViewController: UIViewController {

    weak var delegate: MenuViewControllerDelegete?

    var sideMenuView: SideMenuView {
        let rect = CGRect(x: 0, y: 0,
                          width: ScreenSize.screenWidth - ScreenSize.screenWidth * 0.22,
                          height: ScreenSize.screenHeight)
        let view = SideMenuView(frame: rect)

        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = sideMenuView
        // Do any additional setup after loading the view.

        let menuTableView = (view as? SideMenuView)?.menuTableView ?? {
            print("nil!")
            return UITableView()
        }()
        menuTableView.delegate = self
        menuTableView.dataSource = self

        let navBar = (view as? SideMenuView)?.navBar ?? {
            print("nil")
            return UINavigationBar()
        }()

        navBar.topItem?.leftBarButtonItem?.target = self
        navBar.topItem?.leftBarButtonItem?.action = #selector(didTabCancelButton)
    }

    @objc
    func didTabCancelButton() {
        print("called")
        delegate?.didTapCancelButton()
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuTable = (view as? SideMenuView)?.menuTableView
        let menuOption = MenuOptions.allCases[indexPath.row]

        guard let cell = menuTable?.dequeueReusableCell(withIdentifier: "cell", for: indexPath) else {
            return UITableViewCell()
        }

        cell.textLabel?.text = menuOption.rawValue
        let img = UIImage(systemName: menuOption.imageName)?
            .withRenderingMode(.alwaysOriginal)
            .withTintColor(.lightGray)
        cell.imageView?.image = img


        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelect(menuItem: MenuOptions.allCases[indexPath.row])
    }
}
