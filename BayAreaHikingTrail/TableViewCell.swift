//
//  TableViewCell.swift
//  BayAreaHikingTrails
//
//  Created by Jake Min on 3/7/16.
//  Copyright © 2016 DeAnzaCollege. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var NameLabel: UILabel!
    @IBOutlet var CityLabel: UILabel!
    @IBOutlet var LengthLabel: UILabel!
    @IBOutlet var TimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
