//
//  WelcomeViewController.swift
//  Weather tracker
//
//  Created by Misha on 11.11.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    let viewModel = DayWeatherViewModel(weatherService: WeatherService())
    let twentyFourHoursViewModel = TwentyFourHoursViewModel(twentyFourHoursWeatherService: TwentyFourHoursWeatherService())
    let weekViewModel = WeekViewModel(weekWeatherService: WeekWeatherService())
    let locationViewModel = LocationViewModel(locationService: LocationManager(), locationGroup: LocationGroup())
    let locationGroup = LocationGroup()
    
    var onboardImage: UIImageView = {
        var onboardImage = UIImageView()
        onboardImage.translatesAutoresizingMaskIntoConstraints = false
        onboardImage.image = UIImage(named: "Onboard")
        return onboardImage
        }()
  
    var permitLabel: UILabel = {
        let permitLabel = UILabel()
        permitLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        permitLabel.text = "Разрешить приложению  Weather использовать данные \nо местоположении вашего устройства"
        permitLabel.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        permitLabel.textAlignment = .left
        permitLabel.numberOfLines = 0
        permitLabel.lineBreakMode = .byWordWrapping
        permitLabel.translatesAutoresizingMaskIntoConstraints = false
        return permitLabel
        }()
    
    var getLabel: UILabel = {
        let getLabel = UILabel()
        getLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        getLabel.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        getLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        getLabel.textAlignment = .left
        getLabel.numberOfLines = 3
        getLabel.lineBreakMode = .byWordWrapping
        getLabel.translatesAutoresizingMaskIntoConstraints = false
        return getLabel
        }()
    
    var changeLabel: UILabel = {
        let getLabel = UILabel()
        getLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        getLabel.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        getLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        getLabel.textAlignment = .left
        getLabel.numberOfLines = 3
        getLabel.lineBreakMode = .byWordWrapping
        getLabel.translatesAutoresizingMaskIntoConstraints = false
        return getLabel
        }()
    
    var agreeButton: UIButton = {
        let agreeButton = UIButton()
        agreeButton.layer.cornerRadius = 10
        agreeButton.clipsToBounds = true
        agreeButton.layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        agreeButton.addTarget(self, action: #selector(agreeButtonPressed), for: .touchUpInside)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        return agreeButton
    }()
    
    var agreeButtonLabel: UILabel = {
        let agreeButtonLabel = UILabel()
        agreeButtonLabel.font = UIFont(name: "Rubik-Regular", size: 12)
        agreeButtonLabel.text = "ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА"
        agreeButtonLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        agreeButtonLabel.textAlignment = .center
        agreeButtonLabel.adjustsFontSizeToFitWidth = true
        agreeButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        return agreeButtonLabel
        }()
    
    var disagreeButton: UIButton = {
        let disagreeButton = UIButton()
        disagreeButton.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        disagreeButton.addTarget(self, action: #selector(disagreeButtonPressed), for: .touchUpInside)
        disagreeButton.translatesAutoresizingMaskIntoConstraints = false
        return disagreeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(onboardImage)
        view.layer.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        
        view.addSubview(permitLabel)
        view.addSubview(getLabel)
        view.addSubview(changeLabel)
        view.addSubview(agreeButton)
        view.addSubview(agreeButtonLabel)
        view.addSubview(disagreeButton)
        
        
        let constraints = [
        
            onboardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            onboardImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            onboardImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            permitLabel.widthAnchor.constraint(equalToConstant: 322),
            permitLabel.heightAnchor.constraint(equalToConstant: 63),
            permitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            permitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 426),
            
            getLabel.widthAnchor.constraint(equalToConstant: 314),
            getLabel.heightAnchor.constraint(equalToConstant: 60),
            getLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            getLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 519),
            
            changeLabel.widthAnchor.constraint(equalToConstant: 322),
            changeLabel.heightAnchor.constraint(equalToConstant: 50),
            changeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            changeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 569),
            
            agreeButton.widthAnchor.constraint(equalToConstant: 340),
            agreeButton.heightAnchor.constraint(equalToConstant: 40),
            agreeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            agreeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 649),
            
            agreeButtonLabel.widthAnchor.constraint(equalToConstant: 296),
            agreeButtonLabel.heightAnchor.constraint(equalToConstant: 15),
            agreeButtonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            agreeButtonLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 662),

            disagreeButton.widthAnchor.constraint(equalToConstant: 322),
            disagreeButton.heightAnchor.constraint(equalToConstant: 21),
            disagreeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            disagreeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 714)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func agreeButtonPressed() {
        WelcomeCore.shared.setIsNotNewUser()
        let viewModel = GeneralViewModel(
            locationGroup: locationGroup,
            locationManager: LocationManager(),
            weatherService: WeatherService(),
            twentyFourHoursWeatherService: TwentyFourHoursWeatherService(),
            weekWeatherService: WeekWeatherService(),
            newWeatherService: NewCityWeatherService(),
            newTFHWeatherService: NewCityTFHWeatherService(),
            newCityWeekWeatherService: NewCityWeekWeatherService())
        let mainScreenViewController = MainScrenenViewController(viewModel: viewModel, locationViewModel: locationViewModel)
        navigationController?.present(mainScreenViewController, animated: true, completion: nil)
    }
    
    @objc func disagreeButtonPressed() {
        print("456")
    }
    
}
