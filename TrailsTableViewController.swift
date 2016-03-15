//
//  TrailsTableViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/3/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class TrailsTableViewController: UITableViewController, UISearchResultsUpdating {

    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    @IBOutlet var menuButton: UIBarButtonItem!

    var trails:[Trail]?
    var searchController: UISearchController!
    var searchResults: [Trail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 150
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        let fr = NSFetchRequest(entityName: "Trail")
        let e: NSError? = nil
        
        trails = (try! moc.executeFetchRequest(fr)) as! [Trail]
        
        if e != nil{
            print("viewDidAppear Failed to retrieve record: \(e!.localizedDescription)")
        }
        else{
            
            self.tableView.reloadData()
            
        }
    }
    override func viewDidAppear(animated: Bool) {
        let fr = NSFetchRequest(entityName: "Trail")
        let e: NSError? = nil
        
        trails = (try! moc.executeFetchRequest(fr)) as! [Trail]
        
        if e != nil{
            print("viewDidAppear Failed to retrieve record: \(e!.localizedDescription)")
        }
        else{
            
            self.tableView.reloadData()
            
        }
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
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrailCell", forIndexPath: indexPath)

        // Configure the cell...
        
        //var trailItem: Trail!
        if searchController.active{
            //trailItem = searchResults[indexPath.row]
            cell.textLabel!.text = searchResults[indexPath.row].tName
        }
        else{
             if (trails?.count > 0){
            cell.textLabel!.text = trails![indexPath.row].tName
            }
            //cell.textLabel!.text = "Trail Peak"//trails[indexPath.row].tName
        }
        
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
            (TrailItem:Trail)->Bool in let nameMatch = TrailItem.tName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return nameMatch != nil
            
            
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }

}
