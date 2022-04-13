//
//  WeatherService.swift
//  Weather tracker
//
//  Created by Misha on 30.11.2021.
//

import Foundation
import CoreLocation

protocol IWeatherService {
    
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<CitiesWeather, Error>) -> Void)
    
}

enum WeatherServiceError: Error {
    case badUrl
    case lastKnownLocationIsEmpty
}

final class WeatherService: IWeatherService {
     
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String {
       return "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&units=metric&appid=6554673c226a724c0b5a9afa11ed4d6f&lang=ru"
    }
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<CitiesWeather, Error>) -> Void) {
        
        guard let location = location ?? LocationManager.shared.lastKnowLocation else {
            completion(.failure(WeatherServiceError.lastKnownLocationIsEmpty))
            return
        }
        
        let locValue : CLLocationCoordinate2D = location.coordinate
        print(locValue)
            
        //Проверка, что у нас есть url адрес
        guard let url = URL(string: self.weatherURLString(forCoordinates: locValue)) else {
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



