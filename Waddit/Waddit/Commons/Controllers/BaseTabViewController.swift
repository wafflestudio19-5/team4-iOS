//
//  BaseTabViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import UIKit


protocol BaseTabViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class BaseTabViewController: UIViewController {
    weak var delegate: BaseTabViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let navVC = self.navigationController else {
            print("navigation controller nil!")
            return
        }

        if navVC.isNavigationBarHidden {
            navVC.isNavigationBarHidden = false
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal")?.withRenderingMode(.alwaysOriginal).withTintColor(.black),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        // Do any additional setup after loading the view.


        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.view.backgroundColor = .white

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }

    @objc
    func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}
