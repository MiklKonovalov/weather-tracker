//
//  WeekWeatherData.swift
//  Weather tracker
//
//  Created by Misha on 09.12.2021.
//

import Foundation

struct WeekWeather: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Double
    let current: Current
    let minutely: [Minutely]?
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
            case lat, lon, timezone
            case timezoneOffset = "timezone_offset"
            case current, minutely, daily
        }
}

// MARK: - Current
struct Current: Decodable {
    let dt, sunrise, sunset: Int
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint: Double
    let uvi, clouds, visibility: Double
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherWeek]

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

// MARK: - Weather
struct WeatherWeek: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

    enum CodingKeys: String, CodingKey {
            case dt, sunrise, sunset, moonrise, moonset
            case moonPhase = "moon_phase"
            case temp
            case feelsLike = "feels_like"
            case pressure, humidity
            case dewPoint = "dew_point"
            case windSpeed = "wind_speed"
            case windDeg = "wind_deg"
            case windGust = "wind_gust"
            case weather, clouds, pop, rain, uvi
        }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Decodable {
    let day, min, max, night: Double?
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Decodable {
    let dt, precipitation: Double
}

