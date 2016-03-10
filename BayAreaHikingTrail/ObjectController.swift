//
//  ObjectController.swift
//  BayAreaHikingTrails
//
//  Created by Jake Min on 3/7/16.
//  Copyright © 2016 DeAnzaCollege. All rights reserved.
//

import UIKit
import CoreData

class ObjectController: NSObject {
    var iFile1 = ""
    var iFile2 = ""
    var iFile3 = ""
    var iFile4 = ""
    var iName = ""
    var iCity = ""
    var iAddress = ""
    var iLength = ""
    var iTime = ""
    var iExposure = ""
    var iTraffic = ""
    var iSurface = ""
    var iDifficulty = ""
    var iSeason = ""
    var iRule = ""
    var iDetail = ""
    
    
    init(iName: String, iCity: String, iAddress: String, iLength: String, iTime: String, iExposure: String, iTraffic: String, iSurface: String, iDifficulty: String, iSeason: String, iRule: String, iDetail: String, iFile1: String, iFile2: String, iFile3: String, iFile4: String) {
        self.iName = iName
        self.iCity = iCity
        self.iAddress = iAddress
        self.iLength = iLength
        self.iTime = iTime
        self.iExposure = iExposure
        self.iTraffic = iTraffic
        self.iSurface = iSurface
        self.iDifficulty = iDifficulty
        self.iSeason = iSeason
        self.iRule = iRule
        self.iDetail = iDetail
        self.iFile1 = iFile1
        self.iFile2 = iFile2
        self.iFile3 = iFile3
        self.iFile4 = iFile4
    }

}
