//
//  LogInViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit
import JGProgressHUD

class LogInViewController: FormViewController {

    var loginView: LogInView = {
        let rect = UIScreen.main.bounds
        let view = LogInView(frame: rect)
        view.scrollView.keyboardDismissMode = .interactive

        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginView
        navigationController?.setNavigationBarHidden(true, animated: true)

        loginView.navBar.topItem?.leftBarButtonItem?.target = self
        loginView.navBar.topItem?.leftBarButtonItem?.action = #selector(didTabCancelButton)

        (view as? LogInView)!.continueButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)

        self.lowestElement = loginView.footerView
        self.scrollView = loginView.scrollView
        self.formContainerStackView = loginView.formContainerStackView
        self.moveLowestElement = true

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

    }


    @objc
    func didTabCancelButton() {
        if let navVC = self.navigationController {
            navVC.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc
    func handleLogin() {
        print("login")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Logging In"
        hud.show(in: view)


        // TODO: NetworkCode
    }
}
