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
    func addLocation(_ name: String, completion: @escaping ((NewCityData) -> Void))
    
    func fetchLocation() -> CLLocationCoordinate2D?
    
}

//Подписываем класс под протокол
class LocationGroup: ILocationGroup {
    
    //1.Принимаем название города из UIAlert в MainScreenViewController
    func addLocation(_ name: String, completion: @escaping ((NewCityData) -> Void)) {
        
        //2.Подставляем полученное в MainScreenViewController name в геокодинг
        //let url = "http://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=5&appid=b382e4a70dfb690b16b9381daac545ac&lang=ru"
        ///?format=json&apikey=eb4f47dd-5f32-454e-b59c-4685eb278597&geocode=\(name)
        
        var components = URLComponents(string: "https://geocode-maps.yandex.ru/1.x")
        
        let items: [URLQueryItem] = [
            .init(name: "format", value: "json"),
            .init(name: "apikey", value: "eb4f47dd-5f32-454e-b59c-4685eb278597"),
            .init(name: "geocode", value: "\(name)"),
        ]
        
        //3. Парсим JSON
        components?.queryItems = items
        
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
    
            do {
                let result = try JSONDecoder().decode(NewCityData.self, from: data)
                completion(result)
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
        guard let data = UserDefaults.standard.object(forKey: "Coord") as? Data, let coordinates = try? decoder.decode(NewCityData.self, from: data).response
        else {
            return nil
        }

        let latAndLon = coordinates.geoObjectCollection.featureMember.first?.geoObject.point.pos
        
        let splits = latAndLon?.split(separator: " ").map(String.init)
        
        let lat = ((splits?[0] ?? "0") as NSString).doubleValue
        let lon = ((splits?[1] ?? "1") as NSString).doubleValue
        
        print(lat)
        print(lon)
        
        return .init(latitude: lat, longitude: lon)
    }
}

