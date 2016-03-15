//
//  TrailEditorViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/14/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class TrailEditorViewController: UIViewController{

    var newTrail:Trail!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var conditionsField: UITextField!
    @IBOutlet weak var phoneNumField: UITextField!
    
    @IBAction func saveAction(sender: AnyObject) {
        let myMOC = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        newTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: myMOC) as! Trail
        
        newTrail.tName = self.nameField.text!
        newTrail.tAddress = self.addressField.text!
        newTrail.tDistance = self.distanceField.text!
        newTrail.tPhoneNumber = self.phoneNumField.text!
        newTrail.tPictures = ""
        
        do{
            try myMOC.save()
        }catch{
            print("Insert to DB Error: \(error)")
        }
        print("added:" + newTrail.tName + "success")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 150
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
