//
//  ViewController.swift
//  testNiblsoft
//
//  Created by Руслан on 12.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!   
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var countryLabel : UILabel!
    @IBOutlet weak var cilyLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func getWeatherData(_ sender: UIButton) {
            NetworkService.shared.getData { (response) in
                self.countryLabel.text = response.location.country ?? ""
                self.cilyLabel.text = response.location.region ?? ""
                self.temeratureLabel.text = String(describing: "\(response.current.temp_c)°")
                let imgURL = NSURL(string: "http:\(String(describing: response.current.condition.icon))")
                if imgURL != nil {
                    let data = NSData(contentsOf: (imgURL as URL?)!)
                    self.imageWeather.image = UIImage(data: data! as Data)
                }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        latitudeLabel.text = String(myLocation.latitude)
        longitudeLabel.text = String(myLocation.longitude)
        latitude = String(myLocation.latitude)
        longitude = String(myLocation.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            } else {
                if let place = placemark?[0] {
                    self.addressLabel.text = "\(String(describing: place.thoroughfare ?? ""))"
                }
            }
        }
   
    }
    
}

