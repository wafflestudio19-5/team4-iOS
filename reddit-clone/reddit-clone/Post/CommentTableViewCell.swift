//
//  CommentTableViewCell.swift
//  reddit-clone
//
//  Created by MinWoo Park on 2022/01/04.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var commentData: UILabel!
    
    @IBOutlet weak var voteUpButton: UIButton!
    @IBOutlet weak var voteDownButton: UIButton!
    
    @IBOutlet weak var voteUpNumLabel: UILabel!
    @IBOutlet weak var voteDownNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let postDataSize = commentData.sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        commentData.frame.size = postDataSize
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
