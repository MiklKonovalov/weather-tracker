//
//  TwentyFourHoursViewModel.swift
//  Weather tracker
//
//  Created by Misha on 02.12.2021.
//

import Foundation

class TwentyFourHoursViewModel {
    
    let twentyFourHoursWeatherService: ITwentyFourHoursWeatherService
    
    var twentyFourHoursWeather: TwentyFourHoursMainScreenWeatherModel?
    
    init(twentyFourHoursWeatherService: ITwentyFourHoursWeatherService) {
        self.twentyFourHoursWeatherService = twentyFourHoursWeatherService
    }
    
    func twentyFourHoursViewDidLoad() {
        
        twentyFourHoursWeatherService.getCitiesWeather { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                self.twentyFourHoursWeather = .init(
                    twentyFourHoursTime: [result.list[0].dtTxt, result.list[1].dtTxt, result.list[2].dtTxt, result.list[3].dtTxt, result.list[4].dtTxt, result.list[5].dtTxt, result.list[6].dtTxt],
                    twentyFourHoursIcon: [result.list[0].weather[0].icon, result.list[1].weather[0].icon, result.list[2].weather[0].icon, result.list[3].weather[0].icon, result.list[4].weather[0].icon, result.list[5].weather[0].icon, result.list[6].weather[0].icon],
                    twentyFourHoursTemp: [result.list[0].main.temp, result.list[1].main.temp, result.list[2].main.temp, result.list[3].main.temp, result.list[4].main.temp, result.list[5].main.temp, result.list[6].main.temp]
                )
                self.twentyFourHoursWeatherDidChange?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var twentyFourHoursWeatherDidChange: (() -> Void)?
}


