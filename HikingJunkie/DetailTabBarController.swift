//
//  DetailTabBarController.swift
//  HikingJunkie
//
//  Created by profile on 3/7/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DetailTabBarController: UITabBarController {
    
    var selectedTrail:Trail!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let infoVC = self.viewControllers![0] as! DetailInfoViewController
        let imagesVC = self.viewControllers![1] as! DetailImagesViewController
        let directionsVC = self.viewControllers![2] as! DetailMapViewController
        
        infoVC.selectedTrail = self.selectedTrail
        imagesVC.selectedTrail = self.selectedTrail
        directionsVC.selectedTrail = self.selectedTrail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
    }
    */
}
