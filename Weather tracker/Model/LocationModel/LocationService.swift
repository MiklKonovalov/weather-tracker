//
//  LocationService.swift
//  Weather tracker
//
//  Created by Misha on 13.12.2021.
//

import Foundation
import CoreLocation

protocol ILocationService {
    
    func getUserLocation(completion: @escaping ((CLLocation) -> Void))
}

class LocationManager: NSObject, ILocationService, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            print(location)
            
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
            
            if let adminRegion = place.administrativeArea {
                name += ", \(adminRegion)"
            }
            
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        completion?(location)
        
        //Эти значения надо передать в WeatherService
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
        manager.stopUpdatingLocation()
        
    }
    
    var completion: ((CLLocation) -> Void)?
    
}



