//
//  ThirdViewController.swift
//  My_Hard_rock_CAFE
//
//  Created by bocal on 20/12/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ThirdViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet var MapView : MKMapView!
    @IBOutlet weak var SegControl: UISegmentedControl!
    let locationManager = CLLocationManager()
    var Current: CLLocationCoordinate2D!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var latitude:CLLocationDegrees  = 48.8966868
        var longitude:CLLocationDegrees = 2.318545
        
        var latDelta:CLLocationDegrees = 0.0001
        var longDelta:CLLocationDegrees = 0.0001
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var schoolLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(schoolLocation, theSpan)
        
        self.MapView.setRegion(theRegion, animated: true)
        
        var theUlmMinsterAnnotation = MKPointAnnotation()
        
        theUlmMinsterAnnotation.coordinate = schoolLocation
        
        theUlmMinsterAnnotation.title = "Ecole 42"
        theUlmMinsterAnnotation.subtitle = "42 Born 2 code"
        
        self.MapView.addAnnotation(theUlmMinsterAnnotation)
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SegmentType(sender: AnyObject)
    {
        if SegControl.selectedSegmentIndex == 0
        {
            MapView.mapType = MKMapType.Standard
        }
        else if SegControl.selectedSegmentIndex == 1
        {
            MapView.mapType = MKMapType.Satellite
        }
        else if SegControl.selectedSegmentIndex == 2
        {
            MapView.mapType = MKMapType.Hybrid
        }
    }
    
    @IBAction func Geoloc(sender: UIButton)
    {
        MapView.centerCoordinate.latitude = Current.latitude
        MapView.centerCoordinate.longitude = Current.longitude
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        Current = locValue
    }
}