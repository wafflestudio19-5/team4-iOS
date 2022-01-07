//
//  ProfileModifyViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2022/01/08.
//

import UIKit

class ProfileModifyViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var decideButton: UIButton!
    
    @IBOutlet weak var selectImageLabel: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var emailDescriptionLabel: UILabel!
    
    @IBOutlet weak var userPasswordLabel: UILabel!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var passwordDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decideButtonClicked(_ sender: Any) {
        
        /*
        if self.userEmailTextField.text == nil && self.userProfileNameTextField.text == nil && self.userPasswordTextField.text == nil {
            return
        }
        var userNameTemp: String?
        var userMailTemp: String?
        var userPasswordTemp: String?
        
        
        if self.userProfileNameTextField.text == nil { userNameTemp = nil }
        else { userNameTemp = self.userProfileNameTextField.text }
        if self.userEmailTextField.text == nil { userMailTemp = nil }
        else { userMailTemp = self.userEmailTextField.text }
        if self.userPasswordTextField.text == nil { userPasswordTemp = nil }
        else { userPasswordTemp = self.userPasswordTextField.text }
        
        
        let postDataTemp = UserInfoChange(email: userNameTemp, username: userMailTemp, password: userPasswordTemp)
        guard let postData = self.jsonEncoding(postData: postDataTemp) else {return}
        
        let token = UserDefaults.standard.object(forKey: "token")
        if token == nil {return}
        
        print(postDataTemp)
        
        self.networkRequest(data: postData, token: token as! String)
        */
        
        let token = UserDefaults.standard.object(forKey: "token")
        if token == nil {return}
        
        var postDataUserName: UserInfoChangeUserName
        var postDataEmail: UserInfoChangeEmail
        var postDataPassWord: UserInfoChangePassWord
        
        if self.userNameTextField.text != ""{
            postDataUserName = UserInfoChangeUserName(username: self.userNameTextField.text!)
            print(postDataUserName)
            guard let postData = self.jsonEncodingName(postData: postDataUserName) else {return}
            self.networkRequest(data: postData, token: token as? String)
        }
        
        if self.userEmailTextField.text != ""{
            postDataEmail = UserInfoChangeEmail(email: self.userEmailTextField.text!)
            guard let postData = self.jsonEncodingEmail(postData: postDataEmail) else {return}
            self.networkRequest(data: postData, token: token as? String)
        }
        
        if self.userPasswordTextField.text != ""{
            postDataPassWord = UserInfoChangePassWord(password: self.userPasswordTextField.text!)
            guard let postData = self.jsonEncodingPassWord(postData: postDataPassWord) else {return}
            self.networkRequest(data: postData, token: token as? String)
        }
    }
}
