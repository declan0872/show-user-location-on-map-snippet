//
//  ViewController.swift
//  show-user-location-on-map-snippet
//
//  Created by Declan on 08/06/2019.
//  Copyright © 2019 Declan Conway. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let regionInMeters: Double  = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationServices()
        
    }
    
    func setupLocationManager() {
        
        //How accurate do you want the map to show the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    
    func centreViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
           setupLocationManager()
            
           //Call checkLocationAuthorization() to determine what permissions the user has given.
           checkLocationAuthorization()
            

        } else {
            // Show alert letting the user know that they need to turn this on.
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Please turn on location services.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func checkLocationAuthorization() {
        
        //Switch case to deal with different cases presented by the user
        switch CLLocationManager.authorizationStatus(){
        
        //When authorised call the function centreViewOnUserLocation() and show user location
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centreViewOnUserLocation()
            break
        
        
        
        case .denied:
            //Show alert telling them how to turn on permissions
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Please give permission to this app to use your location in settings.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            break
        
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        
        
        case .restricted:
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Location is restricted.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            break
        
        
        
        case .authorizedAlways:
            break
        }
       
    }


}

