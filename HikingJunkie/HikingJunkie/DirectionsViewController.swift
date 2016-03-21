//
//  DirectionsViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/15/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController {
    
    @IBOutlet weak var directionsScrollView: UIScrollView!
    
    var directions:[String]!
    var steps:[UITextView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Directions"
        

        var y = 0
        for(var i = 0; i < directions.count; i++){
            let tempView = UITextView(frame: CGRect(x:0, y:y, width:360, height:70))
            tempView.text = String(i+1) + ". " + directions![i]
            tempView.textColor = UIColor.blackColor()
            tempView.textAlignment = .Left
            tempView.font = UIFont(name: (tempView.font?.fontName)!, size:18)
            tempView.layer.borderWidth = 0.5
            tempView.layer.borderColor = UIColor(red: 90/255, green: 117/255, blue: 107/255, alpha: 1.0).CGColor
            tempView.layer.backgroundColor = UIColor(red: 209/255, green: 235/255, blue: 224/255, alpha: 1.0).CGColor
            steps.append(tempView)
            self.directionsScrollView.addSubview(steps[i])
            y += 70
        }
        // Do any additional setup after loading the view.
        //routeTextView.text
    }
    func viewWillAppear(){
        
        for(var i = 0; i < directions.count; i++){
            steps[i].text = directions[i]
            self.directionsScrollView.addSubview(steps[i])
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
