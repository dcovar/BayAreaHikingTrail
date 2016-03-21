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
        
        selectedTrail.tName = "New Name"
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
            self.navigationController!.title = self.selectedTrail.tName!
            self.addressLabel.text = self.selectedTrail.tAddress
            self.cityLabel.text = self.selectedTrail.tCity
            self.phoneNumberLabel.text = String(self.selectedTrail.tPhoneNumber)
            self.distanceLabel.text = String(self.selectedTrail.tDistance)
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
                else{
                    print("Error, contents not found in file: \(imagePaths[i])")
                }
            }
            
            //Start the animation of images
            self.pictureView.animationImages = uiImages
            self.pictureView.animationDuration = Double(uiImages.count * 2)
            self.pictureView.startAnimating()
            

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
