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
    
    var startAddrString:String?
    var endAddrString:String?
    
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    var startPlacemark :CLPlacemark?
    var endPlacemark :CLPlacemark?
    
    @IBOutlet weak var showRouteButton: UIButton!
    
    @IBAction func getDirections(sender: AnyObject) {
        self.getCurrentLocation()
        return

    }
    
    func getCurrentLocation(){
        self.startAddrString = self.startAddress!.text
        self.endAddrString = self.endAddress!.text
        
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
                        self.showRouteButton.hidden = false
                    }
                })
                
            }
        })

        print("Outside gecoding")
        
        
    }
    func showDirections(){
        let directionRequest = MKDirectionsRequest()
        let currentTransportType = MKDirectionsTransportType.Automobile
        var currentRoute : MKRoute?
        self.endAddrString = ""
        
//        let sourcePlacemark = MKPlacemark(placemark: startPlacemark!)
        directionRequest.source = MKMapItem(placemark: MKPlacemark(placemark: self.startPlacemark!))
        
        let sPlacemark = MKPlacemark(placemark: startPlacemark!)
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(placemark: self.endPlacemark!))
        
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
                        self.endAddrString = self.endAddrString! + "\n" + steps[step].instructions
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
        self.showRouteButton.hidden = true
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
        if segue.identifier == "ShowRoute"{
            let routeViewController = segue.destinationViewController as! RouteViewController
            routeViewController.route = endAddrString
        }
    }
    

}
