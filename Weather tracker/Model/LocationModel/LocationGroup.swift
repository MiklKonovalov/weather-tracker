//
//  LocationGroup.swift
//  Weather tracker
//
//  Created by Misha on 20.12.2021.
//

import Foundation
import CoreLocation

//Создаём протокол делегата
protocol ILocationGroup {
    //Надо принять название города
    func addLocation(_ name: String, completion: @escaping ((LocationData) -> Void))
    
    func fetchLocation() -> (Double, Double)?
    
}

//Подписываем класс под протокол
class LocationGroup: ILocationGroup {
    
    //1.Принимаем название города из UIAlert в MainScreenViewController
    func addLocation(_ name: String, completion: @escaping ((LocationData) -> Void)) {
        
        //2.Подставляем полученное в MainScreenViewController name в геокодинг
        let url = "http://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=5&appid=b382e4a70dfb690b16b9381daac545ac"
        
        //3. Парсим JSON
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
    
            do {
                let result = try JSONDecoder().decode(LocationData.self, from: data)
                completion(result)
                
                //3.Сохраняем координаты в UserDefaults
                UserDefaults.standard.set(result, forKey: "Coord")
            }
            catch {
                print("failed to convert \(error)")
            }
        }
        task.resume()
        
    }
    
    func fetchLocation() -> (Double, Double)? {
        
        if let savedCoord = UserDefaults.standard.object(forKey: "Coord") as? Data {
            let decoder = JSONDecoder()
            if let loadedCoord = try? decoder.decode(LocationData.self, from: savedCoord) {
                guard let coordLat = loadedCoord.first?.lat, let coordLon = loadedCoord.first?.lon else { return (1.1, 1.1) }
                return (coordLat, coordLon)
            } else {
                return (1.1, 1.1)
            }
            
        } else {
            return nil
        }
        
    }
    
    
    /*return UserDefaults.standard.array(forKey: "Coord") as? [CLLocationCoordinate2D] ?? [CLLocationCoordinate2D(latitude: 1.1, longitude: 1.1)]*/
}

