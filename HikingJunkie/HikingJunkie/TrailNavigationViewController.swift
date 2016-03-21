//
//  TrailNavigationViewController.swift
//  HikingJunkie
//
//  Created by David Orozco on 3/21/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class TrailNavigationViewController: UINavigationController {

    var typeOfList:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tells the TableViewController whether to display the Home Screen or the Favorites
        let tableVC = self.viewControllers[0] as! TrailsTableViewController
        tableVC.typeOfList = self.typeOfList
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
