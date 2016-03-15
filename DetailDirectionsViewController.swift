//
//  DetailDirectionsViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/11/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailDirectionsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var selectedTrail:Trail!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var startAddress: UITextField!
    @IBOutlet var endAddress: UITextField!
    @IBOutlet var directionsButton: UIButton!
    
    var start:String?
    var end:String?
    
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    var startPlacemark :CLPlacemark?
    var endPlacemark :CLPlacemark?
    
    @IBAction func getDirections(sender: AnyObject) {
        self.getCurrentLocation()
        self.getDestinationLocation()
        
        //print(startPlacemark?.locality)
        //print(endPlacemark?.locality)
        
        if self.endPlacemark?.locality?.isEmpty == false && self.startPlacemark?.locality?.isEmpty == false
        {
            let directionRequest = MKDirectionsRequest()
            let currentTransportType = MKDirectionsTransportType.Automobile
            var currentRoute : MKRoute?
        
            let sourcePlacemark = MKPlacemark(placemark: startPlacemark!)
            directionRequest.source = MKMapItem(placemark: sourcePlacemark)
            
            let destinationPlacemark = MKPlacemark(placemark: endPlacemark!)
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            
            directionRequest.transportType = currentTransportType
        
            let directions = MKDirections(request: directionRequest) as MKDirections
            directions.calculateDirectionsWithCompletionHandler{(routeResponse, routeError) in
                if routeError != nil{
                    print("Error: \(routeError?.localizedDescription)")
                }
                else{
                    let route = routeResponse?.routes[0] as MKRoute!
                    currentRoute = route
                    self.mapView.removeOverlays(self.mapView.overlays)
                    self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                
                    let rect = route.polyline.boundingMapRect
                    self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                
                    if let steps = currentRoute?.steps as [MKRouteStep]!{
                        for step in 0..<steps.count{
                        
                        }
                    }
                }
            }
        }
        else{
            print("no location found")
        }
    }
    
    func getCurrentLocation(){
        self.start = self.startAddress!.text
        
        geoCoder.geocodeAddressString(start!, completionHandler: {
            placemarks, error in
            if error != nil{
                print(error)
                return
            }
            if placemarks != nil && placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.startPlacemark = placemark as CLPlacemark
                
                let annotation = MKPointAnnotation()
                annotation.title = "Starting Point"
                annotation.subtitle = self.start
                annotation.coordinate = placemark.location!.coordinate
                
                self.mapView.showAnnotations([annotation], animated: true)
            }
        })
    }
    func getDestinationLocation(){
        self.end = self.endAddress!.text

        geoCoder.geocodeAddressString(end!, completionHandler: {
            placemarks, error in
            if error != nil{
                print(error)
                return
            }
            if placemarks != nil && placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.startPlacemark = placemark
                
                let annotation = MKPointAnnotation()
                annotation.title = "Destination Point"
                annotation.subtitle = self.start
                annotation.coordinate = placemark.location!.coordinate
                
                self.mapView.showAnnotations([annotation], animated: true)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
        
        if self.mapView.userLocation.location?.description != nil{
            self.startAddress.text = self.mapView.userLocation.location?.description
        }
        else{
            self.startAddress.text = "San Francisco, CA"
        }
        mapView.delegate = self

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
