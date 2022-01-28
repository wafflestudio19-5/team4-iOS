//
//  LogInViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit
import JGProgressHUD
import Alamofire

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

        loginView.navBar.topItem?.rightBarButtonItem?.target = self
        loginView.navBar.topItem?.rightBarButtonItem?.action = #selector(didTabSignUpButton)

        (view as? LogInView)!.continueButton.addTarget(self, action: #selector(self.handleLogin), for: .touchUpInside)

        self.lowestElement = loginView.footerView
        self.scrollView = loginView.scrollView
        self.formContainerStackView = loginView.formContainerStackView
        self.moveLowestElement = true

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

    }

    @objc
    func didTabSignUpButton() {
        guard let pvc = self.presentingViewController else { return }
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle   = .coverVertical
        self.dismiss(animated: false) {
            pvc.present(vc, animated: true)
        }
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

        guard let email = loginView.email.text else { return }
        guard let password = loginView.password.text else { return }

        let logInInfo = AuthRequestData(username: nil, email: email, password: password)
        AF.request(EndPoint(path: "/users/signin/").url, method: .post, parameters: logInInfo, encoder: JSONParameterEncoder.default).validate()
            .response { (dataResponse) in
                hud.dismiss(animated: true)
                debugPrint(dataResponse)

                switch dataResponse.result {
                case .success:
                    print( "Success ")
                    guard let token = dataResponse.response?.allHeaderFields["Authentication"] else {
                        print("something wrong with the token")
                        return
                    }
                    UserManager.token = token as? String
                    self.didTabCancelButton()

                case let .failure(error):
                    print(error)
                }

            }
    }
}
