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
    
    func fetchLocation() -> CLLocationCoordinate2D?
    
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
                
                /*let coordinates: [CLLocationCoordinate2D] = result.map {
                    return .init(latitude: $0.lat, longitude: $0.lon)
                }*/
                //3.Сохраняем массив (координаты) в UserDefaults
                UserDefaults.standard.set(data, forKey: "Coord")
            }
            catch {
                print("failed to convert \(error)")
            }
        }
        task.resume()
        
    }
    
    func fetchLocation() -> CLLocationCoordinate2D? {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.object(forKey: "Coord") as? Data, let coordinates = try? decoder.decode(LocationData.self, from: data).first
        else {
            return nil
        }
        
        return .init(latitude: coordinates.lat, longitude: coordinates.lon)
    }
}

