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
    
    var city: String?
    
    var currentIndex = 0
    
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
        agreeButton.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        agreeButton.titleLabel?.font = agreeButton.titleLabel?.font.withSize(12)
        agreeButton.addTarget(self, action: #selector(agreeButtonPressed), for: .touchUpInside)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        return agreeButton
    }()
    
    var disagreeButton: UIButton = {
        let disagreeButton = UIButton()
        disagreeButton.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        disagreeButton.titleLabel?.font = disagreeButton.titleLabel?.font.withSize(12)
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
        view.addSubview(disagreeButton)
        
        
        let constraints = [
        
            onboardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            onboardImage.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            onboardImage.widthAnchor.constraint(equalToConstant: view.frame.height / 2),
            onboardImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            permitLabel.topAnchor.constraint(equalTo: onboardImage.bottomAnchor, constant: 30),
            permitLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 20 * 2),
            permitLabel.heightAnchor.constraint(equalToConstant: 63),
            permitLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            
            getLabel.topAnchor.constraint(equalTo: permitLabel.bottomAnchor, constant: 30),
            getLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 20 * 2),
            getLabel.heightAnchor.constraint(equalToConstant: 60),
            getLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            
            changeLabel.topAnchor.constraint(equalTo: getLabel.bottomAnchor, constant: 10),
            changeLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 20 * 2),
            changeLabel.heightAnchor.constraint(equalToConstant: 50),
            changeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
             
            agreeButton.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 30),
            agreeButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20 * 2),
            agreeButton.heightAnchor.constraint(equalToConstant: 40),
            agreeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            disagreeButton.topAnchor.constraint(equalTo: agreeButton.bottomAnchor, constant: 30),
            disagreeButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40 * 2),
            disagreeButton.heightAnchor.constraint(equalToConstant: 21),
            disagreeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func agreeButtonPressed() {
        let viewModel = GeneralViewModel(
            locationGroup: locationGroup,
            locationManager: LocationManager(),
            weatherService: WeatherService(),
            twentyFourHoursWeatherService: TwentyFourHoursWeatherService(),
            weekWeatherService: WeekWeatherService(),
            newWeatherService: NewCityWeatherService(),
            newTFHWeatherService: NewCityTFHWeatherService(),
            newCityWeekWeatherService: NewCityWeekWeatherService())
        
        WelcomeCore.shared.setIsNotNewUser()
        
        let mainScreenViewController = MainScrenenViewController(viewModel: viewModel, locationViewModel: locationViewModel, currentIndex: currentIndex)
        let pageViewController = PageViewController(viewModel: viewModel, locationViewModel: locationViewModel, currentIndex: currentIndex ?? 0)
        
        let navigationControllerForAgree = UINavigationController(rootViewController: pageViewController)
        navigationControllerForAgree.modalPresentationStyle = .fullScreen
        present(navigationControllerForAgree, animated: true, completion: nil)
        
    }
    
    @objc func disagreeButtonPressed() {
        let noCityWeatherViewController = NoCityWeatherViewController(viewModel: GeneralViewModel(
                        locationGroup: locationGroup,
                        locationManager: LocationManager(),
                        weatherService: WeatherService(),
                        twentyFourHoursWeatherService: TwentyFourHoursWeatherService(),
                        weekWeatherService: WeekWeatherService(),
                        newWeatherService: NewCityWeatherService(),
                        newTFHWeatherService: NewCityTFHWeatherService(),
                        newCityWeekWeatherService: NewCityWeekWeatherService()))
        let navigationController = UINavigationController(rootViewController: noCityWeatherViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
}


