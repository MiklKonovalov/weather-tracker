//
//  NewCityTFHWeatherService.swift
//  Weather tracker
//
//  Created by Misha on 06.01.2022.
//

import Foundation
import CoreLocation

enum NewCityTFHWeatherServiceError: Error {
    case badUrl
    case lastKnownLocationIsEmpty
}

final class NewCityTFHWeatherService {
     
    var locationGroup: LocationGroup?
    
    func weatherURLString(coordinatesOne: Double, coordinatesTwo: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinatesOne)&lon=\(coordinatesTwo)&cnt=7&units=metric&appid=6554673c226a724c0b5a9afa11ed4d6f&lang=ru"
    }
    
    func getNewCitiesWeather(location: CLLocation?, completion: @escaping (Result<TwentyFourHoursCitiesWeather, Error>) -> Void) {
        
        guard let location = locationGroup?.fetchLocation() else {
            completion(.failure(WeatherServiceError.lastKnownLocationIsEmpty))
            return
        }
        
        let locValueOne = location.latitude
        
        let locValueTwo = location.longitude
            
        //Проверка, что у нас есть url адрес
        guard let url = URL(string: self.weatherURLString(coordinatesOne: locValueOne, coordinatesTwo: locValueTwo)) else {
            return completion(.failure(WeatherServiceError.badUrl))
        }
            
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
    
            do {
                let result = try JSONDecoder().decode(TwentyFourHoursCitiesWeather.self, from: data)
                completion(.success(result))
            }
            catch {
                print("failed to convert \(error)")
            }
    
        }
        task.resume()
    }
        
}
