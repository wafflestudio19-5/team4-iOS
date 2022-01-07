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
        if self.userNameTextField.text == nil && self.userEmailTextField.text == nil && self.userPasswordTextField.text == nil {
            return
        }
        
        let postDataTemp = UserInfoChange(email: self.userEmailTextField.text, username: self.userNameTextField.text, password: self.userPasswordTextField.text)
        guard let postData = self.jsonEncoding(postData: postDataTemp) else {return}
        
        let token = UserDefaults.standard.object(forKey: "token")
        if token == nil {return}
        
        self.networkRequest(data: postData, token: token as! String)
    }
}
