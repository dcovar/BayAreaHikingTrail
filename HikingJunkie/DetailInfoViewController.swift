//
//  DetailInfoViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/4/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var pictureView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var surfaceLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var rulesTextView: UITextView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func editFavoritesAction(sender: AnyObject) {
        if selectedTrail.isFavorite == 0.0{
            selectedTrail.isFavorite = 1.0
            favoritesLabel.text = "Added to Favorites"
            favoritesButton.setImage(UIImage(named:"favorite"), forState: .Normal)
        }
        else{
            selectedTrail.isFavorite = 0.0
            favoritesLabel.text = "Removed from Favorites"
            favoritesButton.setImage(UIImage(named:"unfavorite"), forState: .Normal)
        }
    }
    
    var selectedTrail:Trail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if selectedTrail.isFavorite == 0.0{
            favoritesLabel.text = "Add to Favorites"
            favoritesButton.setImage(UIImage(named:"plus"), forState: .Normal)
        }
        else{
            favoritesLabel.text = "In Favorites"
            favoritesButton.setImage(UIImage(named:"favorite"), forState: .Normal)
        }
        
        if(selectedTrail != nil){
            //Set the values of the text labels/text views
            self.nameLabel.text = self.selectedTrail.tName
            self.nameLabel.textColor = UIColor(red: 114/255.0, green: 156/255.0, blue: 136/255.0, alpha: 1.0)
            
            
            self.addressLabel.text = self.selectedTrail.tAddress
            self.cityLabel.text = self.selectedTrail.tCity
            self.phoneNumberLabel.text = self.selectedTrail.tPhoneNumber
            self.distanceLabel.text = self.selectedTrail.tDistance
            self.timeLabel.text = selectedTrail.tTime
            self.surfaceLabel.text = selectedTrail.tSurface
            self.difficultyLabel.text = selectedTrail.tDifficulty
            self.rulesTextView.insertText(selectedTrail.tRules!)
            self.detailsTextView.insertText(selectedTrail.tDetails!)
            
            
            //load the images
            let images = selectedTrail.tPictures!.componentsSeparatedByString(",")
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            var imagePaths:[String] = []
            var uiImages:[UIImage] = []
            for(var i = 0; i < (images.count - 1); i++){
                imagePaths.append(paths.stringByAppendingPathComponent(images[i]))
                if UIImage(contentsOfFile: imagePaths[i]) != nil{
                    uiImages.append(UIImage(contentsOfFile: imagePaths[i])!)
                }
                else if UIImage(named: images[i]) != nil{
                    uiImages.append(UIImage(named: images[i])!)
                }
                else{
                    print("Error, contents not found in file: \(imagePaths[i])")
                }
            }
            
            //Start the animation of images
            if uiImages.count > 0{
                self.pictureView.animationImages = uiImages
                self.pictureView.animationDuration = Double(uiImages.count * 5)
                self.pictureView.startAnimating()
            }
            else{
                self.pictureView.image = UIImage(named: "not-found")
            }
            

        }
        else{
            self.navigationController!.title = "Oops something went wrong"
        }

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
