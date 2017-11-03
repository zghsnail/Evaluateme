//
//  MoreTableViewCell.swift
//  Test01
//
//  Created by IOS App on 17/1/30.
//  Copyright © 2017年 nova. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {


    @IBOutlet var titleImage: UIImageView!
    
    @IBOutlet var titleLable: UILabel!
    
    @IBOutlet var moreImage:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
