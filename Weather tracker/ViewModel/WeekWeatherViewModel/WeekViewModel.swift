//
//  WeekViewModel.swift
//  Weather tracker
//
//  Created by Misha on 10.12.2021.
//

import Foundation

class WeekViewModel {
    
    let weekWeatherService: IWeekWeatherService
    
    var weekMainScreenViewModel: WeekMainScreenViewModel?
    
    init(weekWeatherService: IWeekWeatherService) {
        self.weekWeatherService = weekWeatherService
    }
    
    func weekViewDidLoad() {
        
        weekWeatherService.getCitiesWeather(location: nil) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                self.weekMainScreenViewModel = .init(
                    weekDate: [result.daily[0].dt,
                               result.daily[1].dt,
                               result.daily[2].dt,
                               result.daily[3].dt,
                               result.daily[4].dt,
                               result.daily[5].dt,
                               result.daily[6].dt],
                    weekIcon: [result.daily[0].weather[0].icon,
                               result.daily[1].weather[0].icon,
                               result.daily[2].weather[0].icon,
                               result.daily[3].weather[0].icon,
                               result.daily[4].weather[0].icon,
                               result.daily[5].weather[0].icon,
                               result.daily[6].weather[0].icon],
                    weekRain: [result.daily[0].rain,
                               result.daily[1].rain,
                               result.daily[2].rain,
                               result.daily[3].rain,
                               result.daily[4].rain,
                               result.daily[5].rain,
                               result.daily[6].rain],
                    weekDescription: [result.daily[0].weather[0].description,
                                      result.daily[1].weather[0].description,
                                      result.daily[2].weather[0].description,
                                      result.daily[3].weather[0].description,
                                      result.daily[4].weather[0].description,
                                      result.daily[5].weather[0].description,
                                      result.daily[6].weather[0].description],
                    weekMinTemp: [result.daily[0].temp.min,
                                  result.daily[1].temp.min,
                                  result.daily[2].temp.min,
                                  result.daily[3].temp.min,
                                  result.daily[4].temp.min,
                                  result.daily[5].temp.min,
                                  result.daily[6].temp.min,],
                    weekMaxTemp: [result.daily[0].temp.max,
                                  result.daily[1].temp.max,
                                  result.daily[2].temp.max,
                                  result.daily[3].temp.max,
                                  result.daily[4].temp.max,
                                  result.daily[5].temp.max,
                                  result.daily[6].temp.max]
                )
                self.weekWeatherDidChange?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
    }
    var weekWeatherDidChange: (() -> Void)?
}

