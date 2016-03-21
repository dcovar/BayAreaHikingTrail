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
    
    // Used to determine whether to display all of the trails or the favorites
    var typeOfList:String = "Home"
    
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
        //Trail(insertIntoManagedObjectContext: moc)
            //addInitialData()

        
        // Menu sidebar
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
        
        do{
            try moc.save()
        }
        catch{
            print(error)
        }
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
        let tempTrails =  frc.fetchedObjects as! [Trail]
        
        switch typeOfList{
            case "Home":
                trails = tempTrails
                self.title = "Home"
                break
            case "Favorites":
                trails!.removeAll()
                for(var i = 0; i < tempTrails.count; i++){
                    if tempTrails[i].isFavorite == true{
                        trails!.append(tempTrails[i])
                    }
                }
                self.title = "Favorites"
                break
        default:
            trails = tempTrails
        }
        
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
            
            
            // Checks if the current trail is in favorites and populates the cell accordingly
            cell.trail = searchResults[indexPath.row] as Trail
            if searchResults[indexPath.row].isFavorite == 0.0{
                cell.favoritesLabel.text = "Add to Favorites"
                cell.favoritesButton.setImage(UIImage(named:"plus"), forState: .Normal)
            }
            else{
                cell.favoritesLabel.text = "In Favorites"
                cell.favoritesButton.setImage(UIImage(named:"favorite"), forState: .Normal)
            }

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
                
                cell.trail = trails![indexPath.row] as Trail
                if trails![indexPath.row].isFavorite == 0.0{
                    cell.favoritesLabel.text = "Add to Favorites"
                    cell.favoritesButton.setImage(UIImage(named:"plus"), forState: .Normal)
                }
                else{
                    cell.favoritesLabel.text = "In Favorites"
                    cell.favoritesButton.setImage(UIImage(named:"favorite"), forState: .Normal)
                }
                
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
            if(newIndexPath != nil){
                tableView.reloadRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            break
        default:
            tableView.reloadData()
        }
        trails = controller.fetchedObjects as? [Trail]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    // Adds the initial data when ran, is only ran once in viewDidLoad before being commented out and restarting app
    func addInitialData(){
        
        var tempTrail:Trail!
        
        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName =  "Rancho San Antonio Open Space Preserve"
        tempTrail.tCity = "Los Altos, CA 94022"
        tempTrail.tAddress = "22500 Cristo Drive"
        tempTrail.tDistance = "5.5 miles."
        tempTrail.tTime = "3 hours"
        tempTrail.tSurface = "Dirt trails and fire roads."
        tempTrail.tDifficulty = "Easy"
        tempTrail.tRules = "Most trails are designated hiking and equestrian only. A few are open to hikers and cyclists only. There are a handful of hiking only trails. Dogs are not permitted."
        tempTrail.tDetails = "This 5.5 mile loop hike is easy, with about 800 feet in elevation change. Trailhead elevation is around 350 feet. The hike is flat for about 1 mile, climbs on a moderate grade to about 1045 feet, descends to about 330 feet, and returns to the trailhead on a level grade. This is a good hike for beginners starting to stretch their legs a bit; experienced hikers will probably find it easy. There are opportunities at Rancho for longer, harder hikes. \n Exposure: Some shade but mostly exposed. \n Season: Nice any time. \n Once in the park, bear right and drive to the last parking lot, at the end of the park road. Lots of parking, but the lots fill up quickly at this popular park. No entrance or parking fees. Maps available at a kiosk inside the park. Pay phone, drinking water, and restrooms in parking area (and pit toilets at Deer Hollow Farm). There are designated handicapped parking spots, and trails are wheelchair accessible. There is no direct public transportation to the park."
        tempTrail.tPictures = "rancho1,rancho2,rancho3,rancho4,"
        tempTrail.isFavorite = 0.0
        
        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName = "Mission Peak Regional Preserve"
        tempTrail.tCity = "Fremont, CA 94539"
        tempTrail.tAddress = "43600 Mission Blvd"
        tempTrail.tDistance = "5.6 miles"
        tempTrail.tTime = "3 hours"
        tempTrail.tSurface =  "Dirt fire roads and trails."
        tempTrail.tDifficulty = "Intermediate"
        tempTrail.tRules = "Most trails are multi-use. A few are open to hikers and horses only (and of course, cows). Dogs are permitted. Park is open from 5 a.m. to 10 p.m., unless otherwise posted."
        tempTrail.tDetails = "This 5.6 mile out and back hike is moderately tough, but manageable, particularly if you visit on a cool day and bring plenty of water. Trailhead elevation is about 400 feet. The park's high point is about 2517 feet; total elevation change for this hike is about 2200 feet. A Bay Area Hiker reader who preferred to remain anonymous describes the route perfectly: this trail is not for beginners or casual 'neighborhood' walkers. It is somewhat steep and continually demanding. \n Exposure: Almost completely exposed. \n Trail traffic: Moderate. \n Season: Muddy in winter, hot in summer, best in spring.\n Lots of parking in a lot at the edge of a residential neighborhood. Respect all no parking signs on the surrounding surface streets, or you may get a ticket. No parking or admission fees. No designated handicapped parking, and preserve trails are not wheelchair accessible. Vault toilet at the edge of the parking lot. No water. Maps available at the information signboard. AC Transit runs several routes along Mission Boulevard, and from there it's a quick and fairly flat walk to the trailhead."
        tempTrail.tPictures = "mission1,mission2,mission3,mission4,"
        tempTrail.isFavorite = 0.0

        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName = "Stevens Creek County Park"
        tempTrail.tCity = "Cupertino, CA 95014"
        tempTrail.tAddress = "11401 Stevens Canyon Rd"
        tempTrail.tDistance = "6.1 miles"
        tempTrail.tTime = "3 hours"
        tempTrail.tSurface = "Dirt trails and fire roads."
        tempTrail.tDifficulty = "Intermediate"
        tempTrail.tRules =  "Some trails are multi-use, some just open to hikers and equestrians, and a few hiking only. Dogs are not allowed on every trail on the hike described below: they are permitted below the dam on Stevens Creek Trail in Stevens Creek County Park, and on the Fremont Older trails."
        tempTrail.tDetails = "This 6.1 mile loop hike is moderate. Trailhead elevation is around 400 feet. The featured hike's high point is about 1170 feet, but one trail wanders up and down considerably, and the hike's total ascent is about 1110 feet. You can take this hike in either direction, but Coyote Ridge Trail is a steep fire road, in my opinion, better hiked down than up.\n Season: Nice any time.\n Exposure: Mix of sun and shade.\n Trail traffic: Moderate.\n $6 entrance/parking fee. Parking for 17 vehicles, and one designated handicapped parking spot. Restrooms and drinking water at picnic area. If you look at the map(s) on line before visiting these parks, note that although the maps show parking areas at the Madrone and Sycamore Group Areas, the gates leading to the areas are not always open. There is some roadside parking at this southern portion of the park, but your best bet is to use the main entrance to Stevens Creek County Park as a trailhead. There is no direct public transportation to the park. Trails are wheelchair accessible for short distances."
        tempTrail.tPictures = "stevens1,stevens2,stevens3,stevens4,"
        tempTrail.isFavorite = 0.0

        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName = "Los Alamitos Creek Trail"
        tempTrail.tCity = "San Jose, CA 95120"
        tempTrail.tAddress = "6602 Camden Ave"
        tempTrail.tDistance = "3.9 miles"
        tempTrail.tTime = "2 hours or less."
        tempTrail.tSurface = "Paved trail"
        tempTrail.tDifficulty = "Easy"
        tempTrail.tRules = "Almaden Lake Park is open from 8 a.m. to one half hour after sunset. Los Alamitos Creek Trail is a multi-use trail. Dogs are permitted, on leash only (dogs are not permitted at the western part of Almaden Lake Park)."
        tempTrail.tDetails = "This 3.9 mile out and back walk is on a paved and nearly flat trail. \nSeason: Nice year round.\nExposure: Mix of shade and sun.\n Trail traffic: Moderate.\n Almaden Lake Park has two (unconnected) parking lots with plenty of parking. No dogs are permitted in the west lot (this is the one accessed by Almaden Expressway), so if you want to bring a dog, use the east entrance trailhead: from CA 85 drive on Almaden Expressway, turn left onto Coleman, right on Winfield, then turn right into the park. $6 parking fees are charged during summer months, but access is free other times of the year. You'll find restrooms, drinking water, and a pay phone at the trailhead. There are no maps of Los Alamitos Creek Trail at the trailhead, but interpretive signs along the trail highlight the route. There are several designated handicapped parking spaces, and trails are well suited to wheelchairs and strollers. This trail is accessible by public transportation. Visit the Transit Info website for details. You can also access this trail via a 25 car trailhead (no fee) on Camden Avenue at Mt. Forest Drive."
        tempTrail.tPictures = "losalamitos1,losalamitos2,losalamitos3,losalamitos4,"
        tempTrail.isFavorite = 0.0

        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName = "Joseph D Grant County Park"
        tempTrail.tCity = "San Jose, CA 95140"
        tempTrail.tAddress = "18405 Mount Hamilton Rd"
        tempTrail.tDistance = "7.5 miles."
        tempTrail.tTime = "3.5 hours."
        tempTrail.tSurface = "Dirt trails and fire roads."
        tempTrail.tDifficulty = "Intermediate"
        tempTrail.tRules = "Most trails are multi-use. A few are closed to cyclists, and a handful are hiking-only. Dogs are only allowed in the campground, picnic and parking areas, and Edwards Field & Trail; they are not permitted on the hike described on this page."
        tempTrail.tDetails = "This 7.5 mile loop hike is moderate, with about 1300 feet in elevation change. The park has high hills and a sloping valley in the middle, with elevation ranging from about 1300 to 2995 feet. Most trails are moderate, but should you visit in summer, be careful not to overexert and dehydrate yourself on the lightly (or not at all) shaded trails.\n Season: Late winter and spring are pleasant; avoid the park during heat waves.\n Exposure: Some shade, but mostly exposed -- not a good choice in summer heat.\n Trail traffic: Light.\n $6 entrance fee (self-registration if kiosk is closed, or if you park elsewhere in the park). Lots of parking in the main area (on the park's map, that's the Visitor Center Area), and a few other smaller lots off Mount Hamilton Road, east of the main entrance. Restrooms located off the parking lot. Maps available at the entrance kiosk, and at the information signboard at the start of Hotel Trail. Pay phone at entrance kiosk. There is no direct public transportation to the park."
        tempTrail.tPictures = "joseph1,joseph2,joseph3,joseph4,"
        tempTrail.isFavorite = 0.0

        
        tempTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: moc) as! Trail
        
        tempTrail.tName = "Santa Teresa County Park"
        tempTrail.tCity = "San Jose, CA 95119"
        tempTrail.tAddress = "260 Bernal Rd"
        tempTrail.tDistance = "3.8 miles"
        tempTrail.tTime = "2 hours"
        tempTrail.tSurface = "Dirt trails and fire roads."
        tempTrail.tDifficulty = "Easy"
        tempTrail.tRules = "Most trails are multi-use. A few restrict bicycles. Dogs are permitted on the hike described below, and are allowed on all park trails (they are restricted from some park areas). Park is open from 8 a.m. to sunset."
        tempTrail.tDetails = "This 3.8 mile hike is easy, with about 550 feet in elevation change. Trailhead elevation is around 600 feet. The park's highest point is around 1155 feet. Santa Teresa is small, and the trails should be manageable for even beginning hikers.\n Season: Best in late winter and spring.\n Exposure: Almost totally exposed.\n Trail traffic: Light-moderate.\n Lots of parking. $6 entrance fee; use the automated payment box (bring sturdy bills, or a lot of change). Designated handicapped parking spots in some parking lots. Wheelchair-accessible restrooms across from Pueblo Group Picnic Area parking lot. Trails are technically accessible to wheelchairs, but I doubt that even with assistance they could be navigated. There are a couple of drinking fountains near the parking lots. Maps available at a signboard near the Pueblo Group Picnic Area. Emergency phone in the northernmost parking lot. There is no direct public transportation to this park, but you can walk from the VTA bus stop."
        tempTrail.tPictures = "teresa1,teresa2,teresa3,teresa4,"
        tempTrail.isFavorite = 0.0
        
        do{
            try moc.save()
        }catch{
            print("Insert to DB Error: \(error)")
        }
        print("added:" + tempTrail.tName! + " successfully")
        
    }
}
