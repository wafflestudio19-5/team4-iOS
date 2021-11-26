//
//  PasswordFindViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/26.
//

import UIKit

class PasswordFindViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var explainLabel: UILabel!

    @IBOutlet weak var usernameHelpLabel: UILabel!
    @IBOutlet weak var troubleHelpLabel: UILabel!
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setHeaderView()
        setMainView()
        setFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    // a function to make sure the interface keyboards go down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Header View
    fileprivate func setHeaderView() {
        titleLabel.text = "Forgot Password"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        // cancel button
        backButton.setTitle("", for: .normal)
        let backImageConfig = UIImage.SymbolConfiguration(textStyle: .subheadline)
        let backImage = UIImage(
            systemName: "arrow.left",
            withConfiguration: backImageConfig
        )
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .systemGray
        
    }
    
    // MARK: - Main View
    fileprivate func setMainView(){
        // Links to help page
        let usernmStr = "Forgot username"
        let troubleStr = "Having trouble?"
        let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,
            .font: UIFont.systemFont(ofSize: 12)
        ]
        
        let usernmAttributedStr = NSAttributedString(string: usernmStr, attributes: linkAttributes)
        
        let troubleAttributedStr = NSAttributedString(string: troubleStr, attributes: linkAttributes)
        
        usernameHelpLabel.attributedText = usernmAttributedStr
        troubleHelpLabel.attributedText = troubleAttributedStr
        
        
        // notification regarding email address
        let str = "Unfortunately, if you have never given us your emial, we will not be able to reset your password."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedStr = NSAttributedString(string: str, attributes: attributes)
        explainLabel.sizeToFit()
        explainLabel.numberOfLines = 2
        
        explainLabel.attributedText = attributedStr
        
        // Textfields
        let verylightGray = CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 0.8)
        
        userNameTextfield.backgroundColor = UIColor(cgColor: verylightGray)
        userNameTextfield.borderStyle = .none
        userNameTextfield.placeholder = "Username"
        userNameTextfield.addLeftPadding()
        
        emailTextfield.backgroundColor = UIColor(cgColor: verylightGray)
        emailTextfield.borderStyle = .none
        emailTextfield.placeholder = "Email address"
        emailTextfield.addLeftPadding()
        
    }
    
    // MARK: - Footer View
    fileprivate func setFooterView() {
        let str = "REQUEST PSSWORD RESET EMAIL"
        let navyColor = CGColor(red: 9/255, green: 9/255, blue: 44/255, alpha: 100)
        let font = UIFont.boldSystemFont(ofSize: 15)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor(white: 1, alpha: 1)
        ]
        let attribtedStr = NSAttributedString(string: str, attributes: attributes)
        
        requestButton.setAttributedTitle(attribtedStr, for: .normal)
        
        // TODO: Need to decouple applyGradient function and make a separate button
        requestButton.applyGradient(colors: [navyColor, navyColor])
    }
        
    @IBAction func backButtonAction(_ sender: Any) {
        print("pressed back")
        self.presentingViewController?.dismiss(animated: true)
    }
}

// MARK: - Keyboard Notification
extension PasswordFindViewController {
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
            print(self.view.frame.height)
            print(self.footerView.frame.origin.y)
            print(self.view.frame.height - self.footerView.frame.origin.y)
            if self.view.frame.height - self.footerView.frame.origin.y < 300 {
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
