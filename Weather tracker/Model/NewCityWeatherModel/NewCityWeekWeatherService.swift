//
//  NewCityWeekWeatherService.swift
//  Weather tracker
//
//  Created by Misha on 06.01.2022.
//

import Foundation
import CoreLocation

enum NewCityWeekWeatherServiceError: Error {
    case badUrl
    case lastKnownLocationIsEmpty
}

final class NewCityWeekWeatherService {
     
    var locationGroup: LocationGroup?
    
    func weatherURLString(coordinatesOne: Double, coordinatesTwo: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinatesOne)&lon=\(coordinatesTwo)&exclude=hourly&units=metric&appid=04865a1fa3d5d2578d52f3d8970c7bf9&lang=ru"
    }
    
    func getNewCitiesWeather(location: CLLocation?, completion: @escaping (Result<WeekWeather, Error>) -> Void) {
        
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
                let result = try JSONDecoder().decode(WeekWeather.self, from: data)
                completion(.success(result))
            }
            catch {
                print("failed to convert \(error)")
            }
    
        }
        task.resume()
    }
        
}
