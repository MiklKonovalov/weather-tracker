//
//  24HoursWeatherService.swift
//  Weather tracker
//
//  Created by Misha on 01.12.2021.
//

import Foundation
import CoreLocation

protocol ITwentyFourHoursWeatherService {
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<TwentyFourHoursCitiesWeather, Error>) -> Void)
    
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String
    
}

enum TwentyFourHoursWeatherServiceError: Error {
    case badUrl
    case lastKnownLocationIsEmpty
}

/*private extension String {
    static let url = "https://api.openweathermap.org/data/2.5/forecast?q=London&cnt=7&units=metric&appid=b382e4a70dfb690b16b9381daac545ac"
}*/
    
final class TwentyFourHoursWeatherService: ITwentyFourHoursWeatherService {
    
    func weatherURLString(forCoordinates coordinates: CLLocationCoordinate2D) -> String {
       return "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&cnt=7&units=metric&appid=b382e4a70dfb690b16b9381daac545ac"
    }
    
    func getCitiesWeather(location: CLLocation?, completion: @escaping (Result<TwentyFourHoursCitiesWeather, Error>) -> Void) {
        
        guard let location = LocationManager.shared.lastKnowLocation else {
            completion(.failure(WeatherServiceError.lastKnownLocationIsEmpty))
            return
        }
        
        let locValue : CLLocationCoordinate2D = location.coordinate
        print(locValue)
        
        guard let url = URL(string: self.weatherURLString(forCoordinates: locValue)) else {
            return completion(.failure(TwentyFourHoursWeatherServiceError.badUrl))
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let result = try JSONDecoder().decode(TwentyFourHoursCitiesWeather.self, from: data)
                completion(.success(result))
            } catch {
                print("failed to convert \(error)")
            }
        }

        task.resume()
    }
}

