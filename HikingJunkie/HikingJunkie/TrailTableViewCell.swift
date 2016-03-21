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
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var favoritesLabel: UILabel!


        //Add to or delete from favorites
    var trail:Trail!
    @IBAction func editFavoritesAction(sender: AnyObject) {
        if trail.isFavorite == 0.0{
            trail.isFavorite = 1.0
            favoritesLabel.text = "Added to Favorites"
            favoritesButton.setImage(UIImage(named:"favorite"), forState: .Normal)
        }
        else{
            trail.isFavorite = 0.0
            favoritesLabel.text = "Removed from Favorites"
            favoritesButton.setImage(UIImage(named:"unfavorite"), forState: .Normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state

    }
    
}