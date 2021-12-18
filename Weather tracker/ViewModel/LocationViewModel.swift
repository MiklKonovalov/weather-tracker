//
//  LocationViewModel.swift
//  Weather tracker
//
//  Created by Misha on 17.12.2021.
//

import Foundation
import CoreLocation

class LocationViewModel {
    
    let locationService: ILocationService
    
    var locationMainScreenViewModel: LocationMainScreenViewModel?
    
    init(locationService: ILocationService) {
        self.locationService = locationService
    }
    
    func locationDidLoad() {
        
        locationService.getUserLocation {[weak self] location in
            guard let self = self else { return }
            self.addMapPin(with: location)
            //self.locationMainScreenViewModel = .init(cityName: location.)
            print(location)
            
        }
        locationDidChange?()
    }
    
    func addMapPin(with location: CLLocation) {
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            guard let self = self else { return }
            
            self.locationMainScreenViewModel = .init(cityName: locationName ?? "No City")
        }
        locationDidChange?()
    }
    
    var locationDidChange: (() -> Void)?
}



