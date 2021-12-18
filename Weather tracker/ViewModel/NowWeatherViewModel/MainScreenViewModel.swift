//
//  MainScreenViewModel.swift
//  Weather tracker
//
//  Created by Misha on 30.11.2021.
//

import Foundation

struct MainScreenViewModel {

    let main: Double?
    let minTemp: Double?
    let maxTemp: Double?
    
    let weatherDescription: MainEnum?
    
    let windSpeed: Double?
    let clouds: Int?
    let humidity: Int?
    
    let sunrise: Date?
    let sunset: Date?
    
    let cityName: String?
}
