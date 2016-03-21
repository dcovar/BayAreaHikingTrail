//
//  DetailImagesViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/11/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DetailImagesViewController: UIViewController {

    var selectedTrail:Trail!
    @IBOutlet weak var imagesScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Images"
        
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        
        // Gets the path of the documents directory where the images are stored
       let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString

        let images = selectedTrail.tPictures!.componentsSeparatedByString(",")
        
        var imageViews :[UIImageView] = []
        for(var i = 0; i < (images.count - 1); i++){
            let imagePath = paths.stringByAppendingPathComponent(images[i])

            var image = UIImage(contentsOfFile: imagePath)
            // It the image path had no contents, check the xcassets
            if(image == nil){
                image = UIImage(named: images[i])
            }
            // If the image is still empty set it to the default image-not-found
            if(image == nil){
                image = UIImage(named: "not-found")
            }
            
            // Add an imageview to the array and customize it
            imageViews.append(UIImageView(frame:CGRect(x: x, y:y, width:120, height:120)))
            imageViews.last!.image = image
            imageViews.last!.contentMode = UIViewContentMode.ScaleAspectFit
            imageViews.last!.layer.borderWidth = 1
            imageViews.last!.layer.borderColor = UIColor(red: 209/255, green: 222/255, blue:217/255, alpha: 1.0).CGColor
            
            // Add the imageview currently being worked on,  as a subview in the scroll view
            imagesScrollView.addSubview(imageViews.last!)
            imagesScrollView.contentMode = UIViewContentMode.ScaleAspectFit

            // Determines the x and y coordinates of the next imageView
            if(x == 240){
                x = 0
                y += 120
            }
            else{
                x += 120
            }
        }
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
