//
//  TrailsTableViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/3/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class TrailsTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    
    var trails:[Trail]?
    var searchController: UISearchController!
    var searchResults: [Trail] = []

    
    
    
    //Core Data Context/Controllers
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc: NSFetchedResultsController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        // RUN THIS ONCE TO BUILD INITIAL DATA
        // could become part of future reset funcitonality
        // var x = Trail(insertIntoManagedObjectContext: moc)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 170
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        
        let fr = NSFetchRequest(entityName: "Trail")
        
        let sd = NSSortDescriptor(key: "tName", ascending: true)
        fr.sortDescriptors = [sd]
        frc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        //var fetchResult = try! frc.performFetch()
        do{
            let fetchResult = try frc.performFetch()
        }catch let error as NSError{
            print(error)
            return
        }
        
        //trails = (try! moc.executeFetchRequest(fr)) as! [Trail]
        trails =  frc.fetchedObjects as! [Trail]
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        //Reload the search bar
        self.tableView.tableHeaderView = self.searchController.searchBar

        // update the data
        let fr = NSFetchRequest(entityName: "Trail")
        
        let sd = NSSortDescriptor(key: "tName", ascending: true)
        fr.sortDescriptors = [sd]
        frc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        //var fetchResult = try! frc.performFetch()
        do{
            let fetchResult = try frc.performFetch()
        }catch let error as NSError{
            print(error)
            return
        }
        trails =  frc.fetchedObjects as! [Trail]
        
        //reload the updated data
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if searchController.active{
            return searchResults.count
        }
        else{
            if (trails?.count > 0){
                return trails!.count
            }
            return 0
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrailCell", forIndexPath: indexPath) as! TrailTableViewCell
        
        // Configure the cell...
        
        cell.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 236/255, alpha: 1.0)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(red: 209/255, green: 222/255, blue:217/255, alpha: 1.0).CGColor
        
        //var trailItem: Trail!
        if searchController.active{
            //trailItem = searchResults[indexPath.row]
            cell.trailName.text = searchResults[indexPath.row].tName
            cell.trailCity.text = searchResults[indexPath.row].tCity
            cell.trailLength.text = searchResults[indexPath.row].tDistance
            cell.trailTime.text = searchResults[indexPath.row].tTime
            

            // Get the filenames of the images
            let images = searchResults[indexPath.row].tPictures!.componentsSeparatedByString(",")
            
            // Get the path of the documents directory of the app
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            var imagePath:String = ""
            var uiImage:UIImage?

            // Get the full path of the image
            imagePath = paths.stringByAppendingPathComponent(images.first!)
            
            // Check if the file has any contents
            if  UIImage(contentsOfFile: imagePath) != nil{
                // Set the image of the cell
                uiImage = UIImage(contentsOfFile: imagePath)
                cell.trailImage.image = uiImage
            }
            else{
                    //Check if the image file is preloaded in the apps assets
                imagePath = images.first!
                if UIImage(named: imagePath) != nil{
                    uiImage = UIImage(named: imagePath)
                    cell.trailImage.image = uiImage
                }
                else{
                    print("\(searchResults[indexPath.row].tName) has no images")
                    cell.trailImage.image = UIImage(named: "not-found")
                }
            }
        }
        else{
            if (trails?.count > 0){
                //trailItem = searchResults[indexPath.row]
                cell.trailName.text = trails![indexPath.row].tName
                cell.trailCity.text = trails![indexPath.row].tCity
                cell.trailLength.text = trails![indexPath.row].tDistance
                cell.trailTime.text = trails![indexPath.row].tTime
                
                
                // Get the filenames of the images
                let images = trails![indexPath.row].tPictures!.componentsSeparatedByString(",")
                
                // Get the path of the documents directory of the app
                let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
                var imagePath:String = ""
                var uiImage:UIImage?
                
                // Get the full path of the image
                imagePath = paths.stringByAppendingPathComponent(images.first!)
                
                // Check if the file has any contents
                if  UIImage(contentsOfFile: imagePath) != nil{
                    // Set the image of the cell
                    uiImage = UIImage(contentsOfFile: imagePath)
                    cell.trailImage.image = uiImage
                }
                else{
                    //Check if the image file is preloaded in the apps assets
                    imagePath = images.first!
                    if UIImage(named: imagePath) != nil{
                        uiImage = UIImage(named: imagePath)
                        cell.trailImage.image = uiImage
                    }
                    else{
                        print("\(trails![indexPath.row].tName) has no images")
                        cell.trailImage.image = UIImage(named: "not-found")
                    }
                }
            }
        }
        
        
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let itemToDelete = frc.objectAtIndexPath(indexPath) as! Trail
            moc.deleteObject(itemToDelete)
            try! moc.save()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetails"{
            if let indPath = self.tableView.indexPathForSelectedRow{
                searchController.view.removeFromSuperview()
                let detailViewController = segue.destinationViewController as! DetailTabBarController
                
                if searchController.active{
                    detailViewController.selectedTrail = searchResults[indPath.row]
                }
                else{
                    detailViewController.selectedTrail = trails![indPath.row]
                }
            }
        }
    }
    
    // SEARCH
    
    func filterContentForSearchText(searchText:String){
        searchResults = trails!.filter({
            (TrailItem:Trail)->Bool in let nameMatch = TrailItem.tName!.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return nameMatch != nil
            
            
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Delete:
            print(indexPath)
            print(newIndexPath)
            var x: [NSIndexPath] = []
            x.append(indexPath!)
            tableView.deleteRowsAtIndexPaths(x, withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case .Update:
            tableView.reloadRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        default:
            tableView.reloadData()
        }
        trails = controller.fetchedObjects as? [Trail]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
