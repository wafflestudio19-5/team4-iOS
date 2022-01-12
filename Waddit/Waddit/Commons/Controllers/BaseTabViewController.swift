//
//  BaseTabViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/12.
//

import UIKit


protocol BaseTabViewControllerDelegate: AnyObject {
    func didTapMenu()
}

class BaseTabViewController: UIViewController {
    weak var delegate: BaseTabViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTapMenuButton))
        // Do any additional setup after loading the view.
    }

    @objc
    func didTapMenuButton() {
        delegate?.didTapMenu()
    }

}
