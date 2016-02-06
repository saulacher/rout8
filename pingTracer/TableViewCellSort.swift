//
//  TableViewCell.swift
//  pingTracer
//
//  Created by Ivan Gutnik on 19/01/16.
//  Copyright (c) 2016 Ivan Gutnik. All rights reserved.
//

import UIKit

class TableViewCellSort: UITableViewCell {

    
    
    
    
    @IBOutlet weak var imageMove: UIImageView!
    
    @IBOutlet weak var delAction: UIButton!
    
    @IBOutlet weak var sortLabel: UILabel!
    
    @IBOutlet weak var affressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
