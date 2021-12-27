//
//  WeekWeatherService.swift
//  Weather tracker
//
//  Created by Misha on 09.12.2021.
//

import Foundation
import CoreLocation

protocol IWeekWeatherService {
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<WeekWeather, Error>) -> Void)
    
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String
    
}

enum WeekWeatherServiceError: Error {
    case badUrl
}

/*private extension String {
    static let url = "https://api.openweathermap.org/data/2.5/onecall?lat=51.30&lon=00.07&exclude=hourly&units=metric&appid=b382e4a70dfb690b16b9381daac545ac&lang=ru"
}*/

final class WeekWeatherService: IWeekWeatherService {
    
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String {
       return "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly&units=metric&appid=b382e4a70dfb690b16b9381daac545ac&lang=ru"
    }
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<WeekWeather, Error>) -> Void) {
        
        guard let location = LocationManager.shared.lastKnowLocation else {
            completion(.failure(WeatherServiceError.lastKnownLocationIsEmpty))
            return
        }
        
        let locValue : CLLocationCoordinate2D = location.coordinate
        print(locValue)
        
        guard let url = URL(string: self.weatherURLString(forCoordinates: locValue)) else {
            return completion(.failure(WeekWeatherServiceError.badUrl))
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

