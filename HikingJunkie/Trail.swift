//
//  Trail.swift
//  HikingJunkie
//
//  Created by profile on 3/3/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class Trail: NSManagedObject {
    @NSManaged var tName:String
    @NSManaged var tCity:String
    @NSManaged var tAddress:String
    @NSManaged var tDistance:String
    @NSManaged var tTime:String
    @NSManaged var tExposure:String
    @NSManaged var tTraffic:String
    @NSManaged var tSurface:String
    @NSManaged var tDifficulty:String
    @NSManaged var tSeason:String
    @NSManaged var tRules:String
    @NSManaged var tDetails:String
    @NSManaged var tPhoneNumber:String
    @NSManaged var tPictures:String
    
    convenience init( insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        self.init()
        var data = [
            ObjectController(iName: "Rancho San Antonio Open Space Preserve", iCity: "City: Los Altos", iAddress: "22500 Cristo Drive, Los Altos, CA 94022",iLength: "Length: 5.5 miles.", iTime: "Hiking Time: 3 hours.", iExposure: "Exposure: Some shade but mostly exposed.", iTraffic: "Trail traffic: Moderate-heavy.", iSurface: "Trail surfaces: Dirt trails and fire roads.", iDifficulty: "Distance, category, and difficulty:\nThis 5.5 mile loop hike is easy, with about 800 feet in elevation change. Trailhead elevation is around 350 feet. The hike is flat for about 1 mile, climbs on a moderate grade to about 1045 feet, descends to about 330 feet, and returns to the trailhead on a level grade. This is a good hike for beginners starting to stretch their legs a bit; experienced hikers will probably find it easy. There are opportunities at Rancho for longer, harder hikes", iSeason: "Season: Nice any time.", iRule: "Rules:\nMost trails are designated hiking and equestrian only. A few are open to hikers and cyclists only. There are a handful of hiking only trails. Dogs are not permitted.", iDetail: "Hiking Trail Details:\nOnce in the park, bear right and drive to the last parking lot, at the end of the park road. Lots of parking, but the lots fill up quickly at this popular park. No entrance or parking fees. Maps available at a kiosk inside the park. Pay phone, drinking water, and restrooms in parking area (and pit toilets at Deer Hollow Farm). There are designated handicapped parking spots, and trails are wheelchair accessible. There is no direct public transportation to the park.", iFile1: "rancho1", iFile2: "rancho2", iFile3: "rancho3", iFile4: "rancho4"),
            ObjectController(iName: "Mission Peak Regional Preserve", iCity: "City: Fremont", iAddress: "43600 Mission Blvd, Fremont, CA 94539",iLength: "Length: 5.6 miles.", iTime: "Hiking Time: 3 hours.", iExposure: "Exposure: Almost completely exposed.", iTraffic: "Trail traffic: Moderate.", iSurface: "Trail surfaces: Dirt fire roads and trails.", iDifficulty: "Distance, category, and difficulty:\nThis 5.6 mile out and back hike is moderately tough, but manageable, particularly if you visit on a cool day and bring plenty of water. Trailhead elevation is about 400 feet. The park's high point is about 2517 feet; total elevation change for this hike is about 2200 feet. A Bay Area Hiker reader who preferred to remain anonymous describes the route perfectly: this trail is not for beginners or casual 'neighborhood' walkers. It is somewhat steep and continually demanding.", iSeason: "Season: Muddy in winter, hot in summer, best in spring.", iRule: "Rules:\nMost trails are multi-use. A few are open to hikers and horses only (and of course, cows). Dogs are permitted. Park is open from 5 a.m. to 10 p.m., unless otherwise posted.", iDetail: "Hiking Trail Details:\nLots of parking in a lot at the edge of a residential neighborhood. Respect all no parking signs on the surrounding surface streets, or you may get a ticket. No parking or admission fees. No designated handicapped parking, and preserve trails are not wheelchair accessible. Vault toilet at the edge of the parking lot. No water. Maps available at the information signboard. AC Transit runs several routes along Mission Boulevard, and from there it's a quick and fairly flat walk to the trailhead.", iFile1: "mission1", iFile2: "mission2", iFile3: "mission3", iFile4: "mission4"),
            ObjectController(iName: "Stevens Creek County Park", iCity: "City: Cupertino", iAddress: "11401 Stevens Canyon Rd, Cupertino, CA 95014",iLength: "Length: 6.1 miles.", iTime: "Hiking Time: 3 hours.", iExposure: "Exposure: Mix of sun and shade.", iTraffic: "Trail traffic: Moderate.", iSurface: "Trail surfaces: Dirt trails and fire roads.", iDifficulty: "Distance, category, and difficulty:\nThis 6.1 mile loop hike is moderate. Trailhead elevation is around 400 feet. The featured hike's high point is about 1170 feet, but one trail wanders up and down considerably, and the hike's total ascent is about 1110 feet. You can take this hike in either direction, but Coyote Ridge Trail is a steep fire road, in my opinion, better hiked down than up.", iSeason: "Season: Nice any time.", iRule: "Rules:\nSome trails are multi-use, some just open to hikers and equestrians, and a few hiking only. Dogs are not allowed on every trail on the hike described below: they are permitted below the dam on Stevens Creek Trail in Stevens Creek County Park, and on the Fremont Older trails.", iDetail: "Hiking Trail Details:\n$6 entrance/parking fee. Parking for 17 vehicles, and one designated handicapped parking spot. Restrooms and drinking water at picnic area. If you look at the map(s) on line before visiting these parks, note that although the maps show parking areas at the Madrone and Sycamore Group Areas, the gates leading to the areas are not always open. There is some roadside parking at this southern portion of the park, but your best bet is to use the main entrance to Stevens Creek County Park as a trailhead. There is no direct public transportation to the park. Trails are wheelchair accessible for short distances.", iFile1: "stevens1", iFile2: "stevens2", iFile3: "stevens3", iFile4: "stevens4"),
            ObjectController(iName: "Los Alamitos Creek Trail", iCity: "City: San Jose", iAddress: "6602 Camden Ave San Jose, CA 95120",iLength: "Length: 3.9 miles.", iTime: "Hiking Time: 2 hours or less.", iExposure: "Exposure: Mix of shade and sun.", iTraffic: "Trail traffic: Moderate.", iSurface: "Trail surfaces: Paved trail.", iDifficulty: "Distance, category, and difficulty:\nVery easy; this 3.9 mile out and back walk is on a paved and nearly flat trail.", iSeason: "Season: Nice year round.", iRule: "Rules:\nAlmaden Lake Park is open from 8 a.m. to one half hour after sunset. Los Alamitos Creek Trail is a multi-use trail. Dogs are permitted, on leash only (dogs are not permitted at the western part of Almaden Lake Park).", iDetail: "Almaden Lake Park has two (unconnected) parking lots with plenty of parking. No dogs are permitted in the west lot (this is the one accessed by Almaden Expressway), so if you want to bring a dog, use the east entrance trailhead: from CA 85 drive on Almaden Expressway, turn left onto Coleman, right on Winfield, then turn right into the park. $6 parking fees are charged during summer months, but access is free other times of the year. You'll find restrooms, drinking water, and a pay phone at the trailhead. There are no maps of Los Alamitos Creek Trail at the trailhead, but interpretive signs along the trail highlight the route. There are several designated handicapped parking spaces, and trails are well suited to wheelchairs and strollers. This trail is accessible by public transportation. Visit the Transit Info website for details. You can also access this trail via a 25 car trailhead (no fee) on Camden Avenue at Mt. Forest Drive.", iFile1: "losalamitos1", iFile2: "losalamitos2", iFile3: "losalamitos3", iFile4: "losalamitos4"),
            ObjectController(iName: "Joseph D Grant County Park", iCity: "City: San Jose", iAddress: "18405 Mount Hamilton Rd San Jose, CA 95140",iLength: "Length: 7.5 miles.", iTime: "Hiking Time: 3.5 hours.", iExposure: "Exposure: Some shade, but mostly exposed -- not a good choice in summer heat.", iTraffic: "Trail traffic: Light.", iSurface: "Dirt trails and fire roads.", iDifficulty: "Distance, category, and difficulty:\nThis 7.5 mile loop hike is moderate, with about 1300 feet in elevation change. The park has high hills and a sloping valley in the middle, with elevation ranging from about 1300 to 2995 feet. Most trails are moderate, but should you visit in summer, be careful not to overexert and dehydrate yourself on the lightly (or not at all) shaded trails.", iSeason: "Season: Late winter and spring are pleasant; avoid the park during heat waves.", iRule: "Rules:\nMost trails are multi-use. A few are closed to cyclists, and a handful are hiking-only. Dogs are only allowed in the campground, picnic and parking areas, and Edwards Field & Trail; they are not permitted on the hike described on this page.", iDetail: "$6 entrance fee (self-registration if kiosk is closed, or if you park elsewhere in the park). Lots of parking in the main area (on the park's map, that's the Visitor Center Area), and a few other smaller lots off Mount Hamilton Road, east of the main entrance. Restrooms located off the parking lot. Maps available at the entrance kiosk, and at the information signboard at the start of Hotel Trail. Pay phone at entrance kiosk. There is no direct public transportation to the park.", iFile1: "joseph1", iFile2: "joseph2", iFile3: "joseph3", iFile4: "joseph4"),
            ObjectController(iName: "Santa Teresa County Park", iCity: "City: San Jose", iAddress: "260 Bernal Rd, San Jose, CA 95119",iLength: "Length: 3.8 miles.", iTime: "Hiking Time: 2 hours.", iExposure: "Exposure: Almost totally exposed.", iTraffic: "Trail traffic: Light-moderate.", iSurface: "Dirt trails and fire roads.", iDifficulty: "Distance, category, and difficulty:\nThis 3.8 mile hike is easy, with about 550 feet in elevation change. Trailhead elevation is around 600 feet. The park's highest point is around 1155 feet. Santa Teresa is small, and the trails should be manageable for even beginning hikers.", iSeason: "Season: Best in late winter and spring.", iRule: "Rules:\nMost trails are multi-use. A few restrict bicycles. Dogs are permitted on the hike described below, and are allowed on all park trails (they are restricted from some park areas). Park is open from 8 a.m. to sunset.", iDetail: "Lots of parking. $6 entrance fee; use the automated payment box (bring sturdy bills, or a lot of change). Designated handicapped parking spots in some parking lots. Wheelchair-accessible restrooms across from Pueblo Group Picnic Area parking lot. Trails are technically accessible to wheelchairs, but I doubt that even with assistance they could be navigated. There are a couple of drinking fountains near the parking lots. Maps available at a signboard near the Pueblo Group Picnic Area. Emergency phone in the northernmost parking lot. There is no direct public transportation to this park, but you can walk from the VTA bus stop.", iFile1: "teresa1", iFile2: "teresa2", iFile3: "teresa3", iFile4: "teresa4")
        ]
        var newTrail:Trail!
        for i in data{
            newTrail = NSEntityDescription.insertNewObjectForEntityForName("Trail", inManagedObjectContext: context!) as! Trail
            
            newTrail.tName = i.iName
            newTrail.tCity = i.iCity
            newTrail.tAddress = i.iAddress
            newTrail.tTime = i.iTime
            newTrail.tExposure = i.iExposure
            newTrail.tTraffic = i.iTraffic
            newTrail.tSurface = i.iSurface
            newTrail.tDifficulty = i.iDifficulty
            newTrail.tSeason = i.iSeason
            newTrail.tRules = i.iRule
            newTrail.tDetails = i.iDetail
            newTrail.tDistance = i.iLength
            newTrail.tPhoneNumber = ""  // objectcontroller doesnt have any
            newTrail.tPictures = ""     // this might need to be modified
            
            
            do{
                try context!.save()
            }catch{
                print("Insert to DB Error: \(error)")
            }
            print("added:" + newTrail.tName + " successfully")
            
        }
        
    }
}