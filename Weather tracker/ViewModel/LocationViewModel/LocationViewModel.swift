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
    
    var locationGroup: LocationGroup
    
    var locationMainScreenViewModel: LocationMainScreenViewModel?
    
    init(locationService: ILocationService, locationGroup: LocationGroup) {
        self.locationService = locationService
        self.locationGroup = locationGroup
    }
    
    func locationDidLoad() {
        
        //Получаем локацию из LocationManager
        locationService.getUserLocation {[weak self] location in
            guard let self = self else { return }
            //self.addMapPin(with: location)
            print("ПОЛУЧЕНА ЛОКАЦИЯ!!!")
            self.locationDidChange?()
        }
    }
    
    func newLocationDidLoad() {
    
    func userDidSelectNewCity(name: String) {
        locationGroup.addLocation(name) { [weak self] info in
            guard let city = info.response.geoObjectCollection.featureMember.first else { return }
            self?.newCityAdded?(city)
        }
    }
    }
    
    func addMapPin(with location: CLLocation) {
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            guard let self = self else { return }

            self.locationMainScreenViewModel = .init(cityName: locationName ?? "No City")
        }
        locationDidChange?()
    }
    
    var locationDidChange: (() -> Void)?
    var newCityAdded: ((FeatureMember) -> Void)?
}



