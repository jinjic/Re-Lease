//
//  ViewController.swift
//  Re-Lease
//
//  Created by Josip Injic on 3/6/15.
//  Copyright (c) 2015 Josip Injic. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
//MARK:- Properties
    
    // Views
    var mapView = MKMapView(frame: CGRectMake(0.0, 0.0, 0.0, 20.0))
 
    // Map properties
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    // Constriants
    var constraints: [NSLayoutConstraint] = []
    var bottomBarBtnConstraints: [NSLayoutConstraint] = []
    var topBarBtnConstraints: [NSLayoutConstraint] = []
    
    lazy var locationButton: UIButton = {
        let button = UIButton(frame: CGRectMake(0.0, 0.0, 100.0, 20.0))
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        let image = UIImage(named: "MyLocationIcon")
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: Selector("currentLocation"), forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
        }()
    
//MARK:- Annotation
    
    var pinA = MKPointAnnotation()
    var pinB = MKPointAnnotation()
    var pinC = MKPointAnnotation()
    var pinD = MKPointAnnotation()
    var pinE = MKPointAnnotation()
    
//MARK:- Main View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize , target: self, action: "notificationsClicked"), animated: true)
        
        view.backgroundColor = UIColor.whiteColor()
        self.setupManager()
        
        self.addConstraints()
    }
    
    func addView() {
        // Main View
        mapView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(mapView)
    }
    
    func addConstraints() {
        self.addView()
        
        let view: [NSObject:AnyObject] = ["map": mapView, "top": self.topLayoutGuide]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[map]|", options: nil, metrics: nil, views: view) as [NSLayoutConstraint]
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:[top][map]|", options: nil, metrics: nil, views: view) as [NSLayoutConstraint]
        
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
//MARK:- Location
    
    func setupManager() {
        //Setup our Map View
        mapView.delegate = self
        mapView.mapType = .Standard
        
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        mapView.pitchEnabled = true
        mapView.rotateEnabled = true
        
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        
        manager.requestAlwaysAuthorization()
    }
    
    func setupAnnotationsWithLocation(location: CLLocationCoordinate2D) {
        var locationA = CLLocationCoordinate2D(latitude: location.latitude - 0.001, longitude: location.longitude - 0.001)
        var locationB = CLLocationCoordinate2D(latitude: location.latitude + 0.001, longitude: location.longitude - 0.001)
        var locationC = CLLocationCoordinate2D(latitude: location.latitude - 0.001, longitude: location.longitude + 0.001)
        var locationD = CLLocationCoordinate2D(latitude: location.latitude - 0.0001, longitude: location.longitude - 0.001)
        var locationE = CLLocationCoordinate2D(latitude: location.latitude + 0.0009, longitude: location.longitude + 0.002)
        
        pinA.setCoordinate(locationA)
        pinB.setCoordinate(locationB)
        pinC.setCoordinate(locationC)
        pinD.setCoordinate(locationD)
        pinE.setCoordinate(locationE)
        
        pinA.title = "David Groomes"
        pinA.subtitle = "Need Help?"
        
        pinB.title = "John Smith"
        pinB.subtitle = "Fixing Cars"
        
        pinC.title = "Darin Brockman"
        pinC.subtitle = "Shoveling Snow"
        
        pinD.title = "Steve Miller"
        pinD.subtitle = "Looking to Volunteer"
        
        pinE.title = "Josip Injic"
        pinE.subtitle = "Computer not working?"
        
        mapView.addAnnotation(pinA)
        mapView.addAnnotation(pinB)
        mapView.addAnnotation(pinC)
        mapView.addAnnotation(pinD)
        mapView.addAnnotation(pinE)
    }
    
// MARK: - CLLocation Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized:
            self.mapView.showsUserLocation = true
        case .Denied:
            /// TODO: alertview for failure
            break
        default:
            break
        }
    }
    
// MARK: - MapView Methods
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        self.centerMapAroundLocationCoordinate2D(userLocation.coordinate)
        self.setupAnnotationsWithLocation(userLocation.coordinate)
    }
    
    private func centerMapAroundLocationCoordinate2D(coordinate: CLLocationCoordinate2D) {
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800)
        self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
    }
    
//MARK:- Buttons
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        manager.delegate = nil
    }
    
    func notificationsClicked() {
        
        let notificaitonsViewController: notificationsViewController = notificationsViewController()
        self.navigationController?.pushViewController(notificaitonsViewController, animated: true)
    }
    
}


