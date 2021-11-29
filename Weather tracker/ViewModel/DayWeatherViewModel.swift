//
//  WeatherViewModel.swift
//  Weather tracker
//
//  Created by Misha on 12.11.2021.
//

import Foundation
import UIKit

class DayWeatherViewModel {
    
    let url = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=b382e4a70dfb690b16b9381daac545ac"
    
    func viewDidLoad() {
        getData(from: url)
    }
    
    func getData(from url: String) {
        
        guard let url = URL(string: url) else {
            print("Failed to parse URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: CitiesWeather?
            do {
                result = try JSONDecoder().decode(CitiesWeather.self, from: data)
                self.weatherDidChange?(result!)
            }
            catch {
                print("failed to convert \(error)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.main?.temp)
            print(json.main?.tempMin)
            print(json.main?.humidity)
            
        }
        
        task.resume()
        
    }
    
    var weatherDidChange: ((CitiesWeather) -> Void)?
}

