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
    
    @IBOutlet weak var buttonsContainer: UIStackView!
    
    let communityCreateBT: UIButton! = {
        let button = UIButton()
        button.setTitle("Create Community", for: .normal)
        button.layer.borderColor = UIColor.systemIndigo.cgColor
        button.setTitleColor(.systemIndigo, for: .normal)
        
        return button
    }()
    
    let userData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityCreateBT.addTarget(self, action: #selector(communityCreate), for: .primaryActionTriggered)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if userData.object(forKey: "token") != nil {
            buttonOne.setTitle("Log out", for: .normal)
            buttonTwo.setTitle("Profile", for: .normal)
            //loginLabel.text = "u/\()"
            buttonsContainer.insertArrangedSubview(communityCreateBT, at: 4)
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
    
    @objc
    func communityCreate() {
        let storyboard = UIStoryboard(name: "CommunityCreate", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CommunityCreateVCID")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
