//
//  TrailTableViewCell.swift
//  HikingJunkie
//
//  Created by Jake Min on 3/15/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class TrailTableViewCell: UITableViewCell {
    @IBOutlet weak var trailImage: UIImageView!
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailCity: UILabel!
    @IBOutlet weak var trailLength: UILabel!
    @IBOutlet weak var trailTime: UILabel!

    
        //Add to or delete from favorites
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state

    }
    
}