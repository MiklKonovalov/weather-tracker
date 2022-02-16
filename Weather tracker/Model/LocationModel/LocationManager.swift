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
    
    var lastKnowLocation: CLLocation?
    
    //Получение локации!
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion //Что это значит?
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
            print("resolveLocationName: \(location)")
            
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
    
    //Получение координат
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first, LocationManager.shared.lastKnowLocation == nil else { return }
        
        LocationManager.shared.lastKnowLocation = location
        
        completion?(location)
        
        manager.stopUpdatingLocation()
   
    }
    
    var completion: ((CLLocation) -> Void)?
    
}



