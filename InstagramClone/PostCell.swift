//
//  PostCell.swift
//  InstagramClone
//
//  Created by Youssef Elabd on 3/19/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var captionLabel: UILabel!

    @IBOutlet weak var postView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
