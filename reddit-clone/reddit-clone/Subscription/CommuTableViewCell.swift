//
//  CommuTableViewCell.swift
//  reddit-clone
//
//  Created by Uiseop Eom on 2021/12/18.
//

import UIKit

class CommuTableViewCell: UITableViewCell {

    @IBOutlet weak var communityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
