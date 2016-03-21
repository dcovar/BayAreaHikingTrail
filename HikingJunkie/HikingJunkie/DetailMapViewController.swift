//
//  DetailMapViewController.swift
//  HikingJunkie
//
//  Created by profile on 3/11/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var selectedTrail:Trail!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var startAddress: UITextField!
    @IBOutlet var endAddress: UITextField!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var drivingButton: UIButton!
    @IBOutlet weak var walkingButton: UIButton!
    @IBOutlet weak var transitButton: UIButton!
    
    var startAddrString:String?
    var endAddrString:String?
    var directionsString:[String] = []
    
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    var startPlacemark :CLPlacemark?
    var endPlacemark :CLPlacemark?
    var transportType:MKDirectionsTransportType?
    
    @IBAction func setTransportAsDriving(sender: AnyObject) {
        self.transportType = MKDirectionsTransportType.Automobile
    }
    @IBAction func setTransportAsWalking(sender: AnyObject) {
        self.transportType = MKDirectionsTransportType.Walking
    }
    @IBAction func setTransportAsTransit(sender: AnyObject) {
        self.transportType = MKDirectionsTransportType.Transit
    }

    @IBAction func showRoute(sender: AnyObject) {
        self.getCurrentLocation()
        return
    }
    
    func getCurrentLocation(){
        self.startAddrString = self.startAddress!.text
        self.endAddrString = self.endAddress!.text!
        
        geoCoder.geocodeAddressString(startAddrString!, completionHandler: {
            placemarks, error in
            if error != nil{
                print(error)
                return
            }
            if placemarks != nil && placemarks!.count > 0 {
                print("Inside!!")
                let placemark = placemarks![0] as CLPlacemark
                self.startPlacemark = placemark
                
                let annotation = MKPointAnnotation()
                annotation.title = "Starting Point"
                annotation.subtitle = self.startAddrString
                annotation.coordinate = placemark.location!.coordinate
                print(annotation.coordinate)
                print("AA")
                
                self.mapView.showAnnotations([annotation], animated: true)
                // done with 1st geocoding
                self.geoCoder.geocodeAddressString(self.endAddrString!, completionHandler: {
                    placemarks, error in
                    if error != nil{
                        print(error)
                        return
                    }
                    
                    if placemarks != nil && placemarks!.count > 0 {
                        print("InsideB!!")
                        let placemark = placemarks![0] as CLPlacemark
                        self.endPlacemark = placemark
                        
                        let annotation = MKPointAnnotation()
                        annotation.title = "Ending Point"
                        annotation.subtitle = self.endAddrString
                        annotation.coordinate = placemark.location!.coordinate
                        print(annotation.coordinate)
                        print("BB")
                        
                        self.mapView.showAnnotations([annotation], animated: true)
                        //done with second geocoding
                        self.showDirections()
                        self.directionsButton.hidden = false
                    }
                })
                
            }
        })
        
        print("Outside gecoding")
        
        
    }
    func showDirections(){
        let directionRequest = MKDirectionsRequest()
        var currentTransportType:MKDirectionsTransportType
        // Get Transportation Type or Set to Default: Automobile
        if transportType == nil{
            currentTransportType = MKDirectionsTransportType.Automobile
        }
        else{
            currentTransportType = transportType!
        }
        var currentRoute : MKRoute?
        
        //        let sourcePlacemark = MKPlacemark(placemark: startPlacemark!)
        directionRequest.source = MKMapItem(placemark: MKPlacemark(placemark: self.startPlacemark!))
        
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(placemark: self.endPlacemark!))
        
        directionRequest.transportType = currentTransportType
        
        let directions = MKDirections(request: directionRequest) as MKDirections
        directions.calculateDirectionsWithCompletionHandler{(routeResponse, routeError) in
            if routeError != nil{
                print("Error: \(routeError?.localizedDescription)")
                
                // Determines what method of transportation was chosen in case there's an error, so that it can display that the method they chose has no available directions
                var type:String
                switch currentTransportType{
                case MKDirectionsTransportType.Walking:
                    type = "Walking"
                    break
                    
                case MKDirectionsTransportType.Transit:
                    type = "Transit"
                    break
                    
                default:
                    type = ""
                }
                let alert = UIAlertController(title: "Error", message:
                    "\(type) directions not available" , preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler:nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                let route = routeResponse?.routes[0] as MKRoute!
                currentRoute = route
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                
                // Clear the directions string and reload the new directions into it
                self.directionsString.removeAll()
                if let steps = currentRoute?.steps as [MKRouteStep]!{
                    for step in 0..<steps.count{
                        self.directionsString.append("\(steps[step].instructions),")
                    }
                    
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3.0
        return renderer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Map"
        
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
        self.endAddress.text = selectedTrail.tAddress! + " " + selectedTrail.tCity!
        
        mapView.delegate = self
        
        // Do any additional setup after loading the view.
        self.directionsButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDirections"{
            let routeViewController = segue.destinationViewController as!DirectionsViewController
            routeViewController.directions = directionsString
        }
    }
    
    
}