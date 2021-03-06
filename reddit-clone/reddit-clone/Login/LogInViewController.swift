//
//  LogInViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/22.
//

import UIKit
import AuthenticationServices
import Firebase
import GoogleSignIn

class LogInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var headerView: UIStackView!
    @IBOutlet weak var cancelBT: UIButton!
    @IBOutlet weak var signupBT: UIButton!
    
    @IBOutlet weak var mainView: UIStackView!
     
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    
    
    @IBOutlet weak var googleAuthButton: UIButton!
    @IBOutlet weak var appleAuthButton: UIButton!
    
    
    @IBOutlet weak var usernmTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    var delegate: LoginProtocol? //login protocol
    var token: String? //token
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHeaderView()
        setMainView()
        setFooterView()
        
        appleAuthButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
        print(presentingViewController)
        if let originalVC = presentingViewController as? HomeViewController {
            DispatchQueue.main.async {
                originalVC.reloadData()
            }
        }
    }
    
    // a function to make sure the interface keyboards go down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Google Login For Custom Button
    @IBAction func googleLogicClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
            if let error = error {
                print(error)
                return
            }
            
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    
                }
                else    {
                    print("Login Successful")
                    AppDelegate.googleUser = user
                    print(user.profile?.email)
                    print(user.profile?.name)
                    print(authentication.accessToken)
                    print(authentication.refreshToken)
                    
                    if authentication.accessToken == nil {return}
                    if authentication.refreshToken == nil {return}
                    let tokenDataTemp = GoogleLogin_token(accessToken: authentication.accessToken, refreshToken: authentication.refreshToken)
                    self.networkRequestGoogleLogin(postData: self.jsonEncodingGoogleLogin(param: tokenDataTemp)!)
                }
            }
    }

    
    // MARK: - Header View
    fileprivate func setHeaderView() {
        // cancel button
        cancelBT.setTitle("", for: .normal)
        let cancelImageConfig = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let cancelImage = UIImage(
            systemName: "xmark",
            withConfiguration: cancelImageConfig
        )
        cancelBT.setImage(cancelImage, for: .normal)
        cancelBT.tintColor = .systemGray
        
        // sign up button
        let font = UIFont.boldSystemFont(ofSize: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let signUpTitle = NSAttributedString(
            string: "Sign Up",
            attributes: attributes
        )
        signupBT.setAttributedTitle(signUpTitle, for: .normal)
    }
    
    // MARK: - Main View
    fileprivate func setMainView() {
        setTitleTermsView()
        setAuthenticationView()
        setTextFieldsView()
    }
    
    // MARK: - Log In Title and Terms Label
    fileprivate func setTitleTermsView() {
        // title label
        let titleStr = "Log In"
        let font = UIFont.boldSystemFont(ofSize: 30)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let loginTitle = NSAttributedString(
            string: titleStr,
            attributes: attributes
        )
        titleLabel?.attributedText = loginTitle
        
        // terms label
        let link1Str = "User Agreement"
        let link2Str = "Privacy Policy"
        let termsStr = String(
            format: "By continuing, you agree to our %@ and %@",
            link1Str,
            link2Str
        )
        
        let termsAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        let attributedStr = NSAttributedString(
            string: termsStr,
            attributes: termsAttributes
        )
        
        let mutableStr = NSMutableAttributedString(attributedString: attributedStr)
        mutableStr.setAttributes(
            linkAttributes,
            range: (termsStr as NSString).range(of: link1Str)
        )
        mutableStr.setAttributes(
            linkAttributes,
            range: (termsStr as NSString).range(of: link2Str)
        )
        termsLabel.sizeToFit()
        termsLabel.numberOfLines = 3
        termsLabel.attributedText = mutableStr
    }
    
    // MARK: - Google and Apple Button
    fileprivate func setAuthenticationView() {
        // TODO: make a sub class of UIButton as rounded button(used often in the application)
        
        // common attributes for the Authentication buttons
        let navyColor = CGColor(red: 9/255, green: 9/255, blue: 44/255, alpha: 100)
        let buttonHeight = 40
        let font = UIFont.boldSystemFont(ofSize: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor(cgColor: navyColor)
        ]
        
        let googleButtonStr = NSAttributedString(
            string: "Continue with Google",
            attributes: attributes
        )
        
        googleAuthButton.setAttributedTitle(googleButtonStr, for: .normal)
        // Button borders
        googleAuthButton.layer.cornerRadius = googleAuthButton.frame.height / 2
        googleAuthButton.layer.borderWidth = 1
        googleAuthButton.layer.borderColor = navyColor
        
        // Button image
        let logoFrame = CGRect(x:15, y: buttonHeight/2 - 8, width: 15, height: 15)
        
        let googleLogoView = UIImageView(frame: logoFrame)
        let googleLogo = UIImage(named: "google-logo")
        googleLogoView.image = googleLogo
        googleLogoView.contentMode = .scaleAspectFill
        googleAuthButton.addSubview(googleLogoView)
        
        // TODO: use struct to set the frame of the imageview
        //logoView?.frame = CGRect(x: 20, y: buttonHeight/2 + 10, width: 20, height: 20)
        
        let appleButtonStr = NSAttributedString(
            string: "Continue with Apple",
            attributes: attributes
        )
        appleAuthButton.setAttributedTitle(appleButtonStr, for: .normal)
        // Button borders
        appleAuthButton.layer.cornerRadius = googleAuthButton.frame.height / 2
        appleAuthButton.layer.borderWidth = 1
        appleAuthButton.layer.borderColor = navyColor
        
        let appleLogoView = UIImageView(frame: logoFrame)
        let appleLogo = UIImage(systemName: "applelogo")?.withRenderingMode(.alwaysOriginal)
        appleLogoView.image = appleLogo
        appleLogoView.contentMode = .scaleAspectFill
        appleAuthButton.addSubview(appleLogoView)
    }
    
    // MARK: - TextFields
    fileprivate func setTextFieldsView() {
        let verylightGray = CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 0.8)
        
        usernmTextField.layer.masksToBounds = true
        usernmTextField.backgroundColor = UIColor(cgColor: verylightGray)
        usernmTextField.layer.cornerRadius = pwTextField.frame.height / 2
        usernmTextField.borderStyle = .none
        
        
        pwTextField.layer.masksToBounds = true
        pwTextField.backgroundColor = UIColor(cgColor: verylightGray)
        pwTextField.layer.cornerRadius = pwTextField.frame.height / 2
        pwTextField.borderStyle = .none
        usernmTextField.placeholder = "Username"
        pwTextField.placeholder = "Password"

        usernmTextField.addLeftPadding()
        pwTextField.addLeftPadding()
        
    }
    
    // MARK: - FooterView
    fileprivate func setFooterView() {
        let verylightGray = CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 0.8)
        let font = UIFont.boldSystemFont(ofSize: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor(cgColor: verylightGray)
        ]
        let attribtedStr = NSAttributedString(string: "Continue", attributes: attributes)
        continueButton.setAttributedTitle(attribtedStr, for: .normal)
        continueButton.applyGradient(colors: [UIColor.systemPink.cgColor, UIColor.systemOrange.cgColor])
    }
    
    @IBAction func findPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PasswordFind", bundle: nil)
        
        let findpwVC = storyboard.instantiateViewController(withIdentifier: "pwfind")
        print("tap find password")
        
        //findpwVC.modalPresentationStyle = .fullScreen
        findpwVC.modalPresentationStyle = .overCurrentContext

        present(findpwVC, animated: true)
    }
    
    @IBAction func tryLogin(_ sender: Any) {
        if (usernmTextField.text == nil) {return}
        if (pwTextField.text == nil) {return}
        
        let dataWillPost: Login_UserData = Login_UserData(email: usernmTextField.text!, password: pwTextField.text!)
        let postData = jsonEncoding(param: dataWillPost)
        networkRequest(postData: postData!)
    }
    
    @IBAction func dimissPage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        print("Apple authentication")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
        
}


extension LogInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            //self.saveUserInKeychain(userIdentifier)
            print(userIdentifier, fullName, email)
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            //self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
        
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed!")
    }
    
    
}

extension LogInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}

// MARK: - Keyboard Notification
extension LogInViewController {
    // Adding Notification
    func addKeyboardNotifications(){
        // install handler that notifies the app when keyboard showup
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification ,
                                               object: nil)
        // install handler that notifies the app when keyboard goes down
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // Removing Notification
    func removeKeyboardNotifications(){
        // remove handler that notifies the app when keyboard showup
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        // remove handler that notifies the app when keyboard goes down
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc func keyboardWillShow(_ noti: NSNotification) {
        // Move the view up
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            // TODO: self.footerView.frame.origin.y shows negative ( -13 ) WTF..?
            if self.view.frame.height - self.footerView.frame.origin.y < 150 {
                self.footerView.frame.origin.y -= (keyboardHeight - self.view.safeAreaInsets.bottom)
            }
        }
        
    }
    
    @objc func keyboardWillHide(_ noti: NSNotification) {
        // Move the view up
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.footerView.frame.origin.y += (keyboardHeight - self.view.safeAreaInsets.bottom)
        }
    }
}
