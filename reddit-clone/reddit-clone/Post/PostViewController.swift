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
    @IBOutlet weak var mainContainer: UIStackView!
    
    var token: String?
    var defaults = UserDefaults.standard
    
    var postNum: Int?
    // list previews to sorting
    var commentData: [Comment] = []
    
    // list after sorting
    var commentList: [Comment] = []
    
    var parentIdTobePosted: Int?
    var groupIdTobePosted: Int?
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "comments"
        textField.addLeftPadding()
        textField.backgroundColor = .green
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let commentBT: UIButton = {
        let button = UIButton()
        button.setTitle("Reply", for: .normal)
        button.layer.cornerRadius = 15
        
        button.backgroundColor = .systemIndigo
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let footer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: - set postHeight
        let postDataSize = postDataLabel.sizeThatFits(CGSize(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude))
        postDataLabel.frame.size = postDataSize
        
        //MARK: - set comment writing textfield
        mainContainer.addArrangedSubview(footer)
        setLayout()
        commentBT.addTarget(self, action: #selector(commentBTClicked), for: .touchUpInside)
    }
    
    func setLayout() {
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        commentBT.widthAnchor.constraint(equalToConstant: 100).isActive = true
        footer.addArrangedSubview(textField)
        footer.addArrangedSubview(commentBT)
    }
    
    func sortComments() {
        var parent: Comment? = nil
        var pointer: Int = 0
        var commentDict: [ Int: [Comment] ] = [:]
        
        for i in 0 ..< commentData.count {
            let depth = commentData[i].depth
            
            commentDict[depth, default: []].append(commentData[i])
        }
        
        // TODO: Recursive comment system tobe implemented
        if let comments = commentDict[0] {
            commentList.append(contentsOf: comments)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Get Token and network request
        token = defaults.object(forKey: "token") as? String
        DispatchQueue.main.async {
            self.networkRequest(_token: self.token)
        }
        
        DispatchQueue.main.async {
            self.networkRequestComments(_token: self.token)
            self.sortComments()
        }
        
    }
    
    //MARK: - tableview setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        let comment = commentList[indexPath.row]
        
        cell.commentDepth = comment.depth
        cell.parentID = comment.parentId
        cell.groupID = comment.groupId
        cell.commentData.text = comment.text
        cell.voteUpNumLabel.text = String(comment.numUpVotes)
        cell.voteDownNumLabel.text = String(comment.numDownVotes)
        
        cell.indentationLevel = comment.depth
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let comment = commentList[indexPath.row]
        self.parentIdTobePosted = comment.parentId
        self.groupIdTobePosted = comment.groupId
    }
    
    
    @IBAction func dismissButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func commentBTClicked() {
        
    }
}
