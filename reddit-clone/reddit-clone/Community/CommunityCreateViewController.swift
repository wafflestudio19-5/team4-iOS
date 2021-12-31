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
        self.token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2NDA5NjMyNzEsImlhdCI6MTY0MDk1MjQ3MSwiZW1haWwiOiJ0ZXN0QG5hdmVyLmNvbSJ9.mGirK0NLZQlUZhlEiv8VBb39enQoTDj4-W2qpnj-Rk4"
        
        let dataset: Community_SendData = Community_SendData(name: communityNameTextField.text!, description: descriptionTextField.text!, topics: ["test"])
        let postData = jsonEncoding(param: dataset)
        
        networkRequest(postData: postData!)
        
    }
}
