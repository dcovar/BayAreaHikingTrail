//
//  MenuViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/14/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.revealViewController().rearViewRevealWidth = 170
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
        

        // Based on which button is clicked, it tells the destination navigation controller which list to display
        switch segue.identifier!{
            case "ShowHome":
                let destinationVC = segue.destinationViewController as!  TrailNavigationViewController
                destinationVC.typeOfList = "Home"
                break
            case "ShowFavorites":
                let destinationVC = segue.destinationViewController as!  TrailNavigationViewController
                destinationVC.typeOfList = "Favorites"
                break
            case "ShowEditor":
                break
            default:
                let destinationVC = segue.destinationViewController as!  TrailNavigationViewController
                destinationVC.typeOfList = "Home"
        }
    }
}
