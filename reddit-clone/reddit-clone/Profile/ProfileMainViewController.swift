//
//  ProfileMainViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2022/01/04.
//

import UIKit

class ProfileMainViewController: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var postTabBarView: UIView!
    
    let defaults = UserDefaults.standard
    var token: String?
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = self.defaults.object(forKey: "token") as? String
        self.networkRequest(_token: token)
    }
    

    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
