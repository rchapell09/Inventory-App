//
//  ItemTableViewCell.swift
//  classproject
//
//  Created by rchapell on 11/7/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var quantlabel: UILabel!
    @IBOutlet weak var picview: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
