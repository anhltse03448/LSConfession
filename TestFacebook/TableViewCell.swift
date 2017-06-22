//
//  TableViewCell.swift
//  TestFacebook
//
//  Created by Anh Tuan on 6/12/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblContent : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
