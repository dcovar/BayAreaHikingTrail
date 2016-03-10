//
//  DetailViewController.swift
//  BayAreaHikingTrails
//
//  Created by Jake Min on 3/7/16.
//  Copyright © 2016 DeAnzaCollege. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var dName: UILabel!
    @IBOutlet var dImage1: UIImageView!
    @IBOutlet var dAddress: UILabel!
    @IBOutlet var dLength: UILabel!
    @IBOutlet var dTime: UILabel!
    @IBOutlet var dExposure: UILabel!
    @IBOutlet var dTraffic: UILabel!
    @IBOutlet var dSurface: UILabel!
    @IBOutlet var dSeason: UILabel!
    @IBOutlet var dDetail: UITextView!
    @IBOutlet var dDifficulty: UITextView!
    @IBOutlet var dRule: UITextView!
    
    
    /*
    var dNameText : String!
    var dImage1Text : String!
    var dLengthText : String!
    var dTimeText : String!
    var dExposureText : String!
    var dTrafficText : String!
    var dSurfaceText : String!
    var dSeasonText : String!
    var dAddressText : String!
    var dRuleText : String!
    var dDetailText : String!
    */
    var BayAreaHikingTrailsDetail : ObjectController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        /*
        self.dName.text = self.dNameText
        self.dImage1.image = UIImage(named: self.dImage1Text)
        self.dLength.text = self.dLengthText
        self.dTime.text = self.dTimeText
        self.dExposure.text = self.dExposureText
        self.dTraffic.text = self.dTrafficText
        self.dSurface.text = self.dSurfaceText
        self.dSeason.text = self.dSeasonText
        self.dAddress.text = self.dAddressText
        self.dRule.text = self.dRuleText
        self.dDetail.text = self.dDetailText
        */
        
        self.dName.text = self.BayAreaHikingTrailsDetail.iName
        self.dImage1.image = UIImage(named: self.BayAreaHikingTrailsDetail.iFile1)
        self.dLength.text = self.BayAreaHikingTrailsDetail.iLength
        self.dTime.text = self.BayAreaHikingTrailsDetail.iTime
        self.dExposure.text = self.BayAreaHikingTrailsDetail.iExposure
        self.dTraffic.text = self.BayAreaHikingTrailsDetail.iTraffic
        self.dSurface.text = self.BayAreaHikingTrailsDetail.iSurface
        self.dSeason.text = self.BayAreaHikingTrailsDetail.iSeason
        self.dAddress.text = self.BayAreaHikingTrailsDetail.iAddress
        self.dRule.text = self.BayAreaHikingTrailsDetail.iRule
        self.dDetail.text = self.BayAreaHikingTrailsDetail.iDetail
        self.dDifficulty.text = self.BayAreaHikingTrailsDetail.iDifficulty
        
        //navigationItem.title = BayAreaHikingTrailsDetail.iName
        
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
