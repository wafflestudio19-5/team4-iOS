//
//  SideMenuViewController.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/11/29.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    
    let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if userData.object(forKey: "token") != nil {
            buttonOne.setTitle("Log out", for: .normal)
            buttonTwo.setTitle("Profile", for: .normal)
            loginLabel.text = "u/UserName"
            
        }
        else {
            buttonOne.setTitle("Log in", for: .normal)
            buttonTwo.setTitle("Sign in", for: .normal)
            loginLabel.text = "Log in required"
        }
    }
    
    
    @IBAction func buttonOneCliked(_ sender: Any) {
        if (userData.object(forKey: "token")) != nil {
            userData.removeObject(forKey: "token")
            buttonOne.setTitle("Log in", for: .normal)
            buttonTwo.setTitle("Sign in", for: .normal)
            loginLabel.text = "Log in required"
        }
        else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVCID") else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
        
    }
    
    
    @IBAction func buttonTwoClicked(_ sender: Any) {
        if (userData.object(forKey: "token")) != nil {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileMainViewControllerVCID") else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
        else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCID") else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
}
