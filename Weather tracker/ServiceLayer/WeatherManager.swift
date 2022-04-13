//
//  WeatherManager.swift
//  Weather tracker
//
//  Created by Misha on 07.04.2022.
//

import Foundation
import CoreLocation

//struct WeatherDAOModel {
//    var now: CitiesWeather?
//    var day: TwentyFourHoursCitiesWeather?
//    var week: WeekWeather?
//}
//
//protocol WeatherManagerDelegate: AnyObject {
//    func setWeather(_ weather: [WeatherDAOModel])
//}
//
//class WeatherManager {
//    private let weatherService: IWeatherService
//    private let twentyFourHoursWeatherService: ITwentyFourHoursWeatherService
//    private let weekWeatherService: IWeekWeatherService
//
//    private let newWeatherService: NewCityWeatherService
//    private let newTFHWeatherService: NewCityTFHWeatherService
//    private let newCityWeekWeatherService: NewCityWeekWeatherService
//
//    weak var delegate: WeatherManagerDelegate?
//
//    //MARK:-Initialization
//
//    init(
//         weatherService: IWeatherService,
//         twentyFourHoursWeatherService: ITwentyFourHoursWeatherService,
//         weekWeatherService: IWeekWeatherService,
//         newWeatherService: NewCityWeatherService,
//         newTFHWeatherService: NewCityTFHWeatherService,
//         newCityWeekWeatherService: NewCityWeekWeatherService)
//    {
//        self.weatherService = weatherService
//        self.twentyFourHoursWeatherService = twentyFourHoursWeatherService
//        self.weekWeatherService = weekWeatherService
//        self.newWeatherService = newWeatherService
//        self.newTFHWeatherService = newTFHWeatherService
//        self.newCityWeekWeatherService = newCityWeekWeatherService
//    }
//
//    func fetchNewData(for location: CLLocation) {
//        let dispatchGroup = DispatchGroup()
//        var now: CitiesWeather?
//        var day: TwentyFourHoursCitiesWeather?
//        var week: WeekWeather?
//
//        dispatchGroup.enter()
//        newWeatherService.getNewCitiesWeather(location: location) { result in
//            switch result {
//            case .success(let response):
//                now = response
//            case .failure(_):
//                break
//            }
//            dispatchGroup.leave()
//        }
//
//        dispatchGroup.enter()
//        newTFHWeatherService.getNewCitiesWeather(location: location) { result in
//            switch result {
//            case .success(let response):
//                day = response
//            case .failure(_):
//                break
//            }
//            dispatchGroup.leave()
//        }
//
//        dispatchGroup.enter()
//        newCityWeekWeatherService.getNewCitiesWeather(location: location) { result in
//            switch result {
//            case .success(let response):
//                week = response
//            case .failure(_):
//                break
//            }
//            dispatchGroup.leave()
//        }
//
//        dispatchGroup.notify(queue: DispatchQueue.main) {
//            guard let now = now, let day = day, let week = week else { return }
//            let weather = WeatherDAOModel(now: now, day: day, week: week)
//            self.delegate?.setWeather([weather])
//        }
//
//    }
//}
