//
//  LoadingTableViewCell.swift
//  reddit-clone
//
//  Created by Minnie on 2022/01/05.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.startAnimating()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
