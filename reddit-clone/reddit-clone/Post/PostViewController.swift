//
//  PostViewController.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2022/01/04.
//

import UIKit

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var subredditNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDataLabel: UILabel!
    
    @IBOutlet weak var voteUpButton: UIButton!
    @IBOutlet weak var voteDownButton: UIButton!
    @IBOutlet weak var voteUpNumLabel: UILabel!
    @IBOutlet weak var voteDownNumLabel: UILabel!
    
    @IBOutlet weak var commentTableView: UITableView!
    var token: String?
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - Get Token
        token = defaults.object(forKey: "token") as? String
        DispatchQueue.main.async {
            self.networkRequest(_token: self.token)
        }
        
        //MARK: - set postHeight
        let postDataSize = postDataLabel.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        postDataLabel.frame.size = postDataSize
        
    }
    
    //MARK: - tableview setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        return cell
    }
    
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
