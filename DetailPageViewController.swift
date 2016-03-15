//
//  DetailPageViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/4/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DetailPageViewController: UIPageViewController {

    var selectedTrail:Trail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch (segue.identifier){
        case "DetailInfo"?:
            let viewController = segue.destinationViewController as! DetailInfoViewController
            viewController.selectedTrail = self.selectedTrail
        
        case "DetailPictures"?:
            let viewControler = segue.destinationViewController as! DetailPicturesViewController
            viewControler.selectedTrail = self.selectedTrail
        case "DetailGPS"?:
            let viewController = segue.destinationViewController as! DetailGPSViewController
            viewController.selectedTrail = self.selectedTrail
            
        default:
            print("Error: View Controller Not Found")
            
        }
    }
    

}
