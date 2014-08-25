//
//  TrackCell.swift
//  FirstSwiftApp
//
//  Created by sumantar on 25/08/14.
//  Copyright (c) 2014 sumantar. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var playIcon: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
