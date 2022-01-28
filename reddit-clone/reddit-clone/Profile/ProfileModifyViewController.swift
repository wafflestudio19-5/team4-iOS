//
//  ProfileModifyViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2022/01/08.
//

import UIKit

class ProfileModifyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var decideButton: UIButton!
    
    @IBOutlet weak var selectImageView: UIImageView!
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
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    
    //MARK: - image select
    @IBAction func selectButtonClicked(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decideButtonClicked(_ sender: Any) {
        
        let token = UserDefaults.standard.object(forKey: "token")
        if token == nil {return}
        
        var postDataImage: UserInfoChangeImage
        var postDataUserName: UserInfoChangeUserName
        var postDataEmail: UserInfoChangeEmail
        var postDataPassWord: UserInfoChangePassWord
        
        if self.selectImageView.image != nil {
            
            postDataImage = UserInfoChangeImage(filename: "test.png")
            self.networkRequestPhotos(_data: self.selectImageView.image!, token: token as? String)
        }
        
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
