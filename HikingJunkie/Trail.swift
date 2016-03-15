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
}