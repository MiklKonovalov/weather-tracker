//
//  TwentyFourHoursWeatherData.swift
//  Weather tracker
//
//  Created by Misha on 02.12.2021.
//

import Foundation

struct TwentyFourHoursCitiesWeather: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lat, lon: Double
}

// MARK: - List
struct List: Decodable {
    let dt: Int
    let main: TwentyFourHoursMain
    let weather: [TwentyFourHoursWeather]
    let clouds: TwentyFourHoursClouds
    let wind: TwentyFourHoursWind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: TwentyFourHoursSys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct TwentyFourHoursClouds: Decodable {
    let all: Int
}

// MARK: - Main
struct TwentyFourHoursMain: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct TwentyFourHoursSys: Decodable {
    let pod: String
}

// MARK: - Weather
struct TwentyFourHoursWeather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct TwentyFourHoursWind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}
