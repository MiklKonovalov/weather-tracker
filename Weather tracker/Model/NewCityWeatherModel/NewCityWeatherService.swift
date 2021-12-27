//
//  NewCityWeatherService.swift
//  Weather tracker
//
//  Created by Misha on 27.12.2021.
//

import Foundation
import CoreLocation

enum NewCityWeatherServiceError: Error {
    case badUrl
    case lastKnownLocationIsEmpty
}

final class NewCityWeatherService {
     
    var locationGroup: LocationGroup?
    
    func weatherURLString(coordinatesOne: Double, coordinatesTwo: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinatesOne)&lon=\(coordinatesTwo)&units=metric&appid=b382e4a70dfb690b16b9381daac545ac&lang=ru"
    }
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<CitiesWeather, Error>) -> Void) {
        
        //Getting new locations from Location Group (Double, Double)
        
        guard let location = locationGroup?.fetchLocation() else {
            completion(.failure(WeatherServiceError.lastKnownLocationIsEmpty))
            return
        }
        
        let locValueOne = location.0
        
        let locValueTwo = location.1
            
        //Проверка, что у нас есть url адрес
        guard let url = URL(string: self.weatherURLString(coordinatesOne: locValueOne, coordinatesTwo: locValueTwo)) else {
            return completion(.failure(WeatherServiceError.badUrl))
        }
            
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
    
            do {
                let result = try JSONDecoder().decode(CitiesWeather.self, from: data)
                completion(.success(result))
            }
            catch {
                print("failed to convert \(error)")
            }
    
        }
        task.resume()
    }
        
}
