//
//  CommunityCreateViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/31.
//

import UIKit

class CommunityCreateViewController: UIViewController {
    
    
    @IBOutlet weak var createCommunityNavigationBar: UINavigationItem!
    
    @IBOutlet weak var communityNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var topicButton: UIButton!
    
    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var token: String?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set Navigation Bar Design
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
    }
    

    // MARK: - Click create button
    @IBAction func createButtonClicked(_ sender: Any) {
        if communityNameTextField.text == nil {return}
        if descriptionTextField.text == nil {return}
        self.token = defaults.object(forKey: "token") as? String
        //get token and move it
        
        let dataset: Community_SendData = Community_SendData(name: communityNameTextField.text!, description: descriptionTextField.text!, topics: ["Programming"])
        let postData = jsonEncoding(param: dataset)
        
        networkRequest(postData: postData!)
        
    }
}
