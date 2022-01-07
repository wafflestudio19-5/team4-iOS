//
//  CommunityHomeViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/31.
//

import UIKit

class CommunityHomeViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    @IBOutlet weak var communityImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberNumLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let defaults = UserDefaults.standard
    var token: String?
    var communityData: community_Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = defaults.object(forKey: "token") as? String
        DispatchQueue.main.async {
            self.networkRequest(_token: self.token)
        }
        // Do any additional setup after loading the view.
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
