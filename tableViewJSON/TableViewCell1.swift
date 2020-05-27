//
//  TableViewCell1.swift
//  tableViewJSON
//
//  Created by macOS on 4/24/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var img:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblText:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
