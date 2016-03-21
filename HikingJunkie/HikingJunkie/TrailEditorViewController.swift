//
//  TrailEditorViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/14/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class TrailEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var newTrail:Trail!
    var imageView:[UIImageView] = []
    var images :[UIImage] = []
    var x = CGFloat(-70.0)
    var y = CGFloat(0.0)
    
    var trailDifficulty = ""
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var surfaceField: UITextField!
    @IBOutlet weak var rulesTextView: UITextView!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var addPicsScrollView: UIScrollView!
    
    @IBAction func easyButtonAction(sender: AnyObject) {
        trailDifficulty = "Easy"
    }
    @IBAction func intermediateButtonAction(sender: AnyObject) {
        trailDifficulty = "Intermediate"
    }
    @IBAction func hardButtonAction(sender: AnyObject) {
        trailDifficulty = "Hard"
    }
    @IBAction func selectPicturesAction(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            
            self.presentViewController(imagePicker, animated: true, completion:nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject: AnyObject]!){
        images.append(image)
        
        if x >= 152{
            x = 0
            y += 46
        }
        else{
            x += 76
        }
        
        imageView.append(UIImageView(frame: CGRect(x: x,y: y, width: 70, height: 43)))
        imageView.last!.image = image
        imageView.last!.contentMode = UIViewContentMode.ScaleAspectFit
        addPicsScrollView.addSubview(imageView.last!)
        addPicsScrollView.contentMode = UIViewContentMode.ScaleAspectFit
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Saves the images picked from the photo library into a documents directory
    func saveImages () {
        var pictures :String = ""
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentationDirectory, inDomains: .UserDomainMask)[0]
        
        for(var i = 0; i < images.count; i++){
            var condensedName = ""
            if let trailName = nameField.text!.componentsSeparatedByString(" ") as [String]!{
                for(var i = 0; i < trailName.count; i++){
                    condensedName += trailName[i]
                }
            }
            let filename = ("\(condensedName)_\(i).png")
            let fileUrl = documentsURL.URLByAppendingPathComponent(filename)
            
            let pngImageData = UIImagePNGRepresentation(images[i])
            pngImageData?.writeToFile(String(fileUrl), atomically: true)
            
            
            //append filename to pictures string with comma seperator
            pictures += "\(filename),"
        }
        //pass pictures string to trail object
        newTrail.tPictures = pictures
    }


    @IBAction func saveAction(sender: AnyObject) {
        let myMOC = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        newTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: myMOC) as! Trail
        
        newTrail.tName = self.nameField.text!
        newTrail.tAddress = self.addressField.text!
        newTrail.tCity = self.cityField.text!
        newTrail.tPhoneNumber = self.phoneField.text!
        newTrail.tDistance = self.distanceField.text!
        newTrail.tTime = self.timeField.text!
        newTrail.tSurface = self.surfaceField.text!
        newTrail.tDifficulty = trailDifficulty
        newTrail.tRules = self.rulesTextView.text!
        newTrail.tDetails = self.rulesTextView.text!
        newTrail.isFavorite = 0.0
        self.saveImages()
        
        do{
            try myMOC.save()
        }catch{
            print("Insert to DB Error: \(error)")
        }
        
        let alert = UIAlertController(title: "Success", message: "Your trail was saved successfully!", preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
            action in
                self.nameField.text = ""
                self.cityField.text = ""
                self.addressField.text = ""
                self.phoneField.text = ""
                self.rulesTextView.text = ""
                self.detailsTextView.text = ""
                for subView in self.addPicsScrollView.subviews{
                    subView.removeFromSuperview()
                    
                }
                self.x = -70
                self.y = 0
            }))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add/Edit Trails"

        //show side bar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 170
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
