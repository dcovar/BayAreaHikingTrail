//
//  TableViewController.swift
//  BayAreaHikingTrails
//
//  Created by Jake Min on 3/7/16.
//  Copyright © 2016 DeAnzaCollege. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var BayAreaTrails = [
        ObjectController(iName: "Rancho San Antonio Open Space Preserve", iCity: "City: Los Altos", iAddress: "22500 Cristo Drive, Los Altos, CA 94022",iLength: "Length: 5.5 miles", iTime: "Hiking Time: 3 hours", iExposure: "Exposure: Some shade but mostly exposed.", iTraffic: "Trail traffic: Moderate-heavy.", iSurface: "Trail surfaces: Dirt trails and fire roads.", iDifficulty: "Distance, category, and difficulty:\nThis 5.5 mile loop hike is easy, with about 800 feet in elevation change. Trailhead elevation is around 350 feet. The hike is flat for about 1 mile, climbs on a moderate grade to about 1045 feet, descends to about 330 feet, and returns to the trailhead on a level grade. This is a good hike for beginners starting to stretch their legs a bit; experienced hikers will probably find it easy. There are opportunities at Rancho for longer, harder hikes", iSeason: "Season: Nice any time.", iRule: "Rules:\nMost trails are designated hiking and equestrian only. A few are open to hikers and cyclists only. There are a handful of hiking only trails. Dogs are not permitted.", iDetail: "Hiking Trail Details:\nOnce in the park, bear right and drive to the last parking lot, at the end of the park road. Lots of parking, but the lots fill up quickly at this popular park. No entrance or parking fees. Maps available at a kiosk inside the park. Pay phone, drinking water, and restrooms in parking area (and pit toilets at Deer Hollow Farm). There are designated handicapped parking spots, and trails are wheelchair accessible. There is no direct public transportation to the park.", iFile1: "rancho1", iFile2: "rancho2", iFile3: "rancho3", iFile4: "rancho4")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func prefersStatusBarHidden() -> Bool {
    return true;
    }
    */
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BayAreaTrails.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BayAreaHikingTrailsCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.NameLabel?.text = BayAreaTrails[indexPath.row].iName
        cell.CityLabel?.text = BayAreaTrails[indexPath.row].iCity
        cell.LengthLabel?.text = BayAreaTrails[indexPath.row].iLength
        cell.TimeLabel?.text = BayAreaTrails[indexPath.row].iTime
        cell.cellImage?.image = UIImage(named: BayAreaTrails[indexPath.row].iFile1)
        
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
        
        if (segue.identifier == "ShowDetail")
        {
            if let indPath = self.tableView.indexPathForSelectedRow
            {
                let DestinationDetailViewController = segue.destinationViewController as! DetailViewController
                DestinationDetailViewController.BayAreaHikingTrailsDetail = BayAreaTrails[indPath.row]
            }
        }
        
    }
    
    
}
