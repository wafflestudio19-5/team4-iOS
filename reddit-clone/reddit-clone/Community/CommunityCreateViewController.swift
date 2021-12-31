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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Set Navigation Bar Design
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
