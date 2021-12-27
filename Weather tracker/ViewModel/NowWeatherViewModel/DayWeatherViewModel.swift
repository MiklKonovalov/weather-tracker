//
//  WeatherViewModel.swift
//  Weather tracker
//
//  Created by Misha on 12.11.2021.
//

import Foundation
import UIKit
import CoreLocation

class DayWeatherViewModel {
    
    //MARK: ~Properties
    let weatherService: IWeatherService
    
    var currentWeather: MainScreenViewModel?
    
    var locationManager: ILocationService?
    
    //MARK: ~Initialization
    init(weatherService: IWeatherService) {
        self.weatherService = weatherService
    }
    
    func viewDidLoad() {
    
        weatherService.getCitiesWeather(location: nil) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                self.currentWeather = .init(
                    main: result.main?.temp,
                    minTemp: result.main?.temp_min,
                    maxTemp: result.main?.temp_max,
                    weatherDescription: result.weather?.first?.main,
                    windSpeed: result.wind?.speed,
                    clouds: result.clouds?.all,
                    humidity: result.main?.humidity,
                    sunrise: result.sys?.sunrise,
                    sunset: result.sys?.sunset,
                    cityName: result.name
                    )
                self.weatherDidChange?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var weatherDidChange: (() -> Void)?
    
    
}

