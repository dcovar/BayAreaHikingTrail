//
//  DetailInfoViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/4/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pictureView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var conditionsLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    var selectedTrail:Trail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(selectedTrail != nil){
            self.nameLabel.text = self.selectedTrail.tName
            self.pictureView.image = UIImage(named:self.selectedTrail.tPictures)
            self.distanceLabel.text = String(self.selectedTrail.tDistance)
            self.addressLabel.text = String(self.selectedTrail.tAddress)
            self.phoneNumberLabel.text = String(self.selectedTrail.tPhoneNumber)
            /*
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
*/
        }
        else{
            self.nameLabel.text = "Oops something went wrong"
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
