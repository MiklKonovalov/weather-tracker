//
//  GeneralViewModel.swift
//  Weather tracker
//
//  Created by Misha on 29.12.2021.
//

import Foundation
import CoreLocation
import RealmSwift

//Данная Вью Модель связывает все сервисы, получение текущей локации, получение локации нового города и передаёёт в контроллер
class GeneralViewModel {
    
    typealias CityWeather = (now: CitiesWeather, day: TwentyFourHoursCitiesWeather, week: WeekWeather, id: Int)
    
    //MARK:-Properties
    let locationManager: LocationManager 
    let locationGroup: LocationGroup
    
    let weatherService: IWeatherService
    let twentyFourHoursWeatherService: ITwentyFourHoursWeatherService
    let weekWeatherService: IWeekWeatherService
    
    let newWeatherService: NewCityWeatherService
    let newTFHWeatherService: NewCityTFHWeatherService
    let newCityWeekWeatherService: NewCityWeekWeatherService
    
    let realm = try! Realm()
    
    var id: Int?
    
    var currentWeather: MainScreenViewModel?
    var twentyFourHoursWeather: TwentyFourHoursMainScreenWeatherModel?
    var weekWeather: WeekMainScreenViewModel?
    
    var cityName: String = ""
    
    private(set) var weather = [CityWeather]()
    
    //MARK:-Initialization
    
    init(locationGroup: LocationGroup,
         locationManager: LocationManager,
         weatherService: IWeatherService,
         twentyFourHoursWeatherService: ITwentyFourHoursWeatherService,
         weekWeatherService: IWeekWeatherService,
         newWeatherService: NewCityWeatherService,
         newTFHWeatherService: NewCityTFHWeatherService,
         newCityWeekWeatherService: NewCityWeekWeatherService)
    {
        self.locationGroup = locationGroup
        self.locationManager = locationManager
        self.weatherService = weatherService
        self.twentyFourHoursWeatherService = twentyFourHoursWeatherService
        self.weekWeatherService = weekWeatherService
        self.newWeatherService = newWeatherService
        self.newTFHWeatherService = newTFHWeatherService
        self.newCityWeekWeatherService = newCityWeekWeatherService
    }
    
    var viewModelDidChange: (() -> Void)?
    var viewModelForNewCityDidChange: (() -> Void)?
    
    //MARK:-Functions
    
    //Вызывается только при добавлении нового города!
    func userDidSelectNewCity(name: String, id: Int) {
        locationGroup.addLocation(name) { [weak self] info in //Передаём название города в декодер

            guard let city = info.response.geoObjectCollection.featureMember.first?.geoObject.point.pos else { return }
            
            let splits = city.split(separator: " ").map(String.init)
            
            let lat = ((splits[1]) as NSString).doubleValue
            let lon = ((splits[0]) as NSString).doubleValue
            
            let location = CLLocation(latitude: lat, longitude: lon)
            self?.fetchData(for: location)
        }
    }
    
    func getCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        locationManager.getUserLocation(completion: completion)
    }
    
    //Новая погода
    func fetchNewData(for location: CLLocation) {
        let dispatchGroup = DispatchGroup()
        var now: CitiesWeather?
        var day: TwentyFourHoursCitiesWeather?
        var week: WeekWeather?

        dispatchGroup.enter()
        newWeatherService.getNewCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                now = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        newTFHWeatherService.getNewCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                day = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        newCityWeekWeatherService.getNewCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                week = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.id = self.realm.objects(Cities.self).first?.id
            guard let now = now, let day = day, let week = week, let id = self.id else { return }
            self.weather.append((now: now, day: day, week: week, id: id))
            self.viewModelForNewCityDidChange?()
        }
        
    }
    
    //Получение локации
    func fetchData(for location: CLLocation) {
        let dispatchGroup = DispatchGroup()
        var now: CitiesWeather?
        var day: TwentyFourHoursCitiesWeather?
        var week: WeekWeather?
        
        dispatchGroup.enter()
        weatherService.getCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                now = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        twentyFourHoursWeatherService.getCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                day = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        weekWeatherService.getCitiesWeather(location: location) { result in
            switch result {
            case .success(let response):
                week = response
            case .failure(_):
                break
            }
            dispatchGroup.leave()
        }
        
        
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.id = 0
            guard let now = now, let day = day, let week = week, let id = self.id else { return }
            self.weather.append((now: now, day: day, week: week, id: id))
            self.viewModelDidChange?()
        }
    }
    
}
