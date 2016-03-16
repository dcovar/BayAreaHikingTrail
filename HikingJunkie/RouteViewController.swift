//
//  RouteViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/15/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class RouteViewController: UIViewController {

    @IBOutlet weak var routeTextView: UITextView!
    
    var route:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        routeTextView.text = route
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
