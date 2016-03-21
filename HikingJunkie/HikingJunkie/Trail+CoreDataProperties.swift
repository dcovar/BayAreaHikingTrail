//
//  Trail+CoreDataProperties.swift
//  HikingJunkie
//
//  Created by profile on 3/18/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Trail {

    @NSManaged var isFavorite: NSNumber?
    @NSManaged var tAddress: String?
    @NSManaged var tCity: String?
    @NSManaged var tDetails: String?
    @NSManaged var tDifficulty: String?
    @NSManaged var tDistance: String?
    @NSManaged var tName: String?
    @NSManaged var tPhoneNumber: String?
    @NSManaged var tPictures: String?
    @NSManaged var tRules: String?
    @NSManaged var tSurface: String?
    @NSManaged var tTime: String?

}
