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
        
        
        var x = CGFloat(100)
        var y = CGFloat(100)
        
       let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString

        let images = selectedTrail.tPictures!.componentsSeparatedByString(",")
        
        var imageViews :[UIImageView] = []
        let textView = UITextView(frame: CGRect(x: x, y: y, width: imagesScrollView.frame.width/2, height: imagesScrollView.frame.height/2))
        for(var i = 0; i < (images.count - 1); i++){
            let imagePath = paths.stringByAppendingPathComponent(images[i])
            
            let image = UIImage(contentsOfFile: imagePath)
            
            if image != nil{
                imageViews.append(UIImageView(frame:CGRect(x: x, y:y, width:100, height:100)))
                imageViews.last!.image = image
                imageViews.last!.contentMode = UIViewContentMode.ScaleAspectFit
            
                imagesScrollView.addSubview(imageViews.last!)
                imagesScrollView.contentMode = UIViewContentMode.ScaleAspectFit
            }
            else{
                textView.insertText("Could not find: \(images[i])\n")
                imagesScrollView.addSubview(textView)
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
