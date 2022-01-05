//
//  PostTableViewCell.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2021/12/01.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var subRedditLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UILabel!
    
    var postId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
