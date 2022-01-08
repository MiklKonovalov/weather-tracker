//
//  CityModel.swift
//  Weather tracker
//
//  Created by Misha on 12.11.2021.
//

import Foundation

struct CitiesWeather: Decodable {
    
    let coord : Coordinate?
    let cod, visibility, id : Int?
    let name : String?
    let base : String?
    let weather: [Weather]?
    let sys: Sys?
    let main: Main?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Date?
    var timezone: Int?
}

struct Coordinate: Decodable {
    
    var longitude: Double?
    var latitude: Double?
}

struct Weather: Decodable {
    
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Sys : Decodable {
    
    let type, id : Int?
    let sunrise, sunset : Date?
    let message : Double?
    let country : String?
}

struct Main : Decodable {
    let temp, temp_min, temp_max : Double?
    let pressure, humidity : Int?
}

struct Wind : Decodable {
    let speed : Double?
    let deg : Int?
}

struct Clouds: Decodable {
    let all: Int?
}

//enum MainEnum: String, Decodable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//    case snow = "Snow"
//}
