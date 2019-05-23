//
//  MapViewController.swift
//  foodDelivery
//
//  Created by Aliaxei on 22/05/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let showRadius:Double = 15000
    let regionRadius:Double = 15000
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 53.0, longitude: 27.0)
    var restaurants: [String: CLLocationCoordinate2D] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        loadRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
            
        else if CLLocationManager.authorizationStatus() == .denied {
            print("Location services were previously denied. Please enable location services for this app in Settings.")
        }
        
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        print("current location: \(currentLocation)")
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in restaurants {
            if(checkRestaurant(location: restaurant.value)){
                mapView.addAnnotation(RestaurantPin(title: restaurant.key, coordinate: restaurant.value))
            }
        }
    }
    
    func checkRestaurant(location: CLLocationCoordinate2D) -> Bool {
        return MKMapPoint(location).distance(to: MKMapPoint(currentLocation)) < showRadius
    }
    
    func loadRestaurants(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Restaurant")
        
        do{
            let results = try managedObjectContext.fetch(fetchRequest)
            for data in results as! [NSManagedObject] {
                let coordinate = CLLocationCoordinate2D(latitude: data.value(forKey: "latitude") as! CLLocationDegrees , longitude: data.value(forKey: "longitude") as! CLLocationDegrees)
                let title = data.value(forKey: "name") as! String
                restaurants[title] = coordinate
                print("restaurant \(title)")
                
            }
        }catch let error as NSError {
            print("Data loading error: \(error)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for locValue in locations{
            //print("locations = \(locValue)")
            currentLocation = locValue.coordinate
            centerMapOnLocation(location: currentLocation)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        print("segue: \(view.annotation?.title)")
        if let annotationTitle = view.annotation?.title
        {
            let coordinate = restaurants[annotationTitle!]
            self.performSegue(withIdentifier: "MapToPaymentScreen", sender: RestaurantPin(title: annotationTitle!, coordinate: coordinate!))
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapToPaymentScreen" {
            if let vc = segue.destination as? PaymentScreenViewController {
                var pin = sender as! RestaurantPin
                vc.restaurantName = pin.title
            }
        }
    }
 

}
