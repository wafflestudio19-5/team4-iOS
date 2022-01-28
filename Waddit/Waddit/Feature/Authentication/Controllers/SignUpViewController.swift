//
//  SignUpViewController.swift
//  Waddit
//
//  Created by Uiseop Eom on 2022/01/10.
//

import UIKit
import JGProgressHUD
import Alamofire

class SignUpViewController: FormViewController {

    var signUpView: SignUpView = {
        let rect = UIScreen.main.bounds
        let view = SignUpView(frame: rect)
        view.scrollView.keyboardDismissMode = .interactive

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = signUpView
        navigationController?.setNavigationBarHidden(true, animated: true)

        signUpView.navBar.topItem?.leftBarButtonItem?.target = self
        signUpView.navBar.topItem?.leftBarButtonItem?.action = #selector(didTabCancelButton)

        signUpView.navBar.topItem?.rightBarButtonItem?.target = self
        signUpView.navBar.topItem?.rightBarButtonItem?.action = #selector(didTabLogInButton)

        (view as? SignUpView)!.continueButton.addTarget(self, action: #selector(self.handleSignUp), for: .touchUpInside)

        self.lowestElement = signUpView.footerView
        self.scrollView = signUpView.scrollView
        self.formContainerStackView = signUpView.formContainerStackView
        self.moveLowestElement = true

        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)

    }

    @objc
    func didTabLogInButton() {
        if let navVC = self.navigationController {
            navVC.pushViewController(SignUpViewController(), animated: true)
            navVC.popViewController(animated: true)
        } else {
            self.present(LogInViewController(), animated: true) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @objc
    func didTabCancelButton() {
        if let navVC = self.navigationController {
            let vc = LogInViewController()
            navVC.show(vc, sender: nil)
        } else {
            self.present(LogInViewController(), animated: true) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @objc
    func handleSignUp() {
        print("SignUp")
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "SignUp"
        hud.show(in: view)


        guard let username = signUpView.username.text else { return }
        guard let email = signUpView.email.text else { return }
        guard let password = signUpView.password.text else { return }

        let signUpInfo = AuthRequestData(username: username, email: email, password: password)
        AF.request(EndPoint(path: "/users/").url, method: .post, parameters: signUpInfo, encoder: JSONParameterEncoder.default).validate()
            .response { (dataResponse) in
                hud.dismiss(animated: true)
                debugPrint(dataResponse)

                switch dataResponse.result {
                case .success:
                    print( "Success ")
                case let .failure(error):
                    print(error)
                }
            }
    }
}
