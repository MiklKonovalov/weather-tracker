//
//  SettingsViewController.swift
//  Weather tracker
//
//  Created by Misha on 26.01.2022.
//

import Foundation
import UIKit
import Locksmith

class SettingsViewController: UIViewController {
    
    //MARK: -Properties
    
    var greyView: UIView = {
        let greyView = UIView()
        greyView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        greyView.layer.cornerRadius = 10
        greyView.translatesAutoresizingMaskIntoConstraints = false
        return greyView
    }()
    
    var settingsLabel: UILabel = {
        let settingsLabel = UILabel()
        settingsLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        settingsLabel.textColor = .black
        settingsLabel.text = "Настройки"
        settingsLabel.lineBreakMode = .byWordWrapping
        settingsLabel.textAlignment = .left
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        return settingsLabel
    }()
    
    var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        temperatureLabel.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        temperatureLabel.text = "Температура"
        temperatureLabel.lineBreakMode = .byWordWrapping
        temperatureLabel.textAlignment = .left
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        return temperatureLabel
    }()
    
    var windSpeedLabel: UILabel = {
        let windSpeedLabel = UILabel()
        windSpeedLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        windSpeedLabel.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        windSpeedLabel.text = "Скорость ветра"
        windSpeedLabel.lineBreakMode = .byWordWrapping
        windSpeedLabel.textAlignment = .left
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        return windSpeedLabel
    }()
    
    var timeFormatLabel: UILabel = {
        let timeFormatLabel = UILabel()
        timeFormatLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        timeFormatLabel.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        timeFormatLabel.text = "Формат времени"
        timeFormatLabel.lineBreakMode = .byWordWrapping
        timeFormatLabel.textAlignment = .left
        timeFormatLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeFormatLabel
    }()
    
    var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.font = UIFont(name: "Rubik-Medium", size: 16)
        notificationLabel.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        notificationLabel.text = "Уведомления"
        notificationLabel.lineBreakMode = .byWordWrapping
        notificationLabel.textAlignment = .left
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        return notificationLabel
    }()
    
    var doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.addTarget(self, action: #selector(doneButtonTap), for: .touchUpInside)
        doneButton.setTitle("Установить", for: .normal)
        doneButton.backgroundColor = .orange
        doneButton.layer.cornerRadius = 10
        doneButton.clipsToBounds = true
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        return doneButton
    }()
    
    var temperatureButton: UIButton = {
        let temperatureButton = UIButton()
        temperatureButton.addTarget(self, action: #selector(temperatureButtonTap), for: .touchUpInside)
        temperatureButton.setTitle("C", for: .normal)
        temperatureButton.backgroundColor = .blue
        temperatureButton.layer.cornerRadius = 5
        temperatureButton.clipsToBounds = true
        temperatureButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        temperatureButton.translatesAutoresizingMaskIntoConstraints = false
        return temperatureButton
    }()
    
    var temperatureFarinheitButton: UIButton = {
        let temperatureFarinheitButton = UIButton()
        temperatureFarinheitButton.addTarget(self, action: #selector(temperatureFarinheitButtonTap), for: .touchUpInside)
        temperatureFarinheitButton.setTitle("F", for: .normal)
        temperatureFarinheitButton.setTitleColor(.black, for: .normal)
        temperatureFarinheitButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        temperatureFarinheitButton.layer.cornerRadius = 5
        temperatureFarinheitButton.clipsToBounds = true
        temperatureFarinheitButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        temperatureFarinheitButton.translatesAutoresizingMaskIntoConstraints = false
        return temperatureFarinheitButton
    }()
    
    var windMileButton: UIButton = {
        let windMileButton = UIButton()
        windMileButton.addTarget(self, action: #selector(windMileButtonButtonTap), for: .touchUpInside)
        windMileButton.setTitle("Mi", for: .normal)
        windMileButton.backgroundColor = .blue
        windMileButton.layer.cornerRadius = 5
        windMileButton.clipsToBounds = true
        windMileButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        windMileButton.translatesAutoresizingMaskIntoConstraints = false
        return windMileButton
    }()
    
    var windKilometersButton: UIButton = {
        let windKilometersButton = UIButton()
        windKilometersButton.addTarget(self, action: #selector(windKilometersButtonTap), for: .touchUpInside)
        windKilometersButton.setTitle("Km", for: .normal)
        windKilometersButton.setTitleColor(.black, for: .normal)
        windKilometersButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        windKilometersButton.layer.cornerRadius = 5
        windKilometersButton.clipsToBounds = true
        windKilometersButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        windKilometersButton.translatesAutoresizingMaskIntoConstraints = false
        return windKilometersButton
    }()
    
    var time12Button: UIButton = {
        let time12Button = UIButton()
        time12Button.addTarget(self, action: #selector(time12ButtonTap), for: .touchUpInside)
        time12Button.setTitle("12", for: .normal)
        time12Button.backgroundColor = .blue
        time12Button.layer.cornerRadius = 5
        time12Button.clipsToBounds = true
        time12Button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        time12Button.translatesAutoresizingMaskIntoConstraints = false
        return time12Button
    }()
    
    var time24Button: UIButton = {
        let time24Button = UIButton()
        time24Button.addTarget(self, action: #selector(time24ButtonTap), for: .touchUpInside)
        time24Button.setTitle("24", for: .normal)
        time24Button.setTitleColor(.black, for: .normal)
        time24Button.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        time24Button.layer.cornerRadius = 5
        time24Button.clipsToBounds = true
        time24Button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        time24Button.translatesAutoresizingMaskIntoConstraints = false
        return time24Button
    }()
    
    var notificationOnButton: UIButton = {
        let notificationOnButton = UIButton()
        notificationOnButton.addTarget(self, action: #selector(notificationOnButtonTap), for: .touchUpInside)
        notificationOnButton.setTitle("On", for: .normal)
        notificationOnButton.backgroundColor = .blue
        notificationOnButton.layer.cornerRadius = 5
        notificationOnButton.clipsToBounds = true
        notificationOnButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        notificationOnButton.translatesAutoresizingMaskIntoConstraints = false
        return notificationOnButton
    }()
    
    var notificationOffButton: UIButton = {
        let notificationOffButton = UIButton()
        notificationOffButton.addTarget(self, action: #selector(notificationOffButtonTap), for: .touchUpInside)
        notificationOffButton.setTitle("Off", for: .normal)
        notificationOffButton.setTitleColor(.black, for: .normal)
        notificationOffButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        notificationOffButton.layer.cornerRadius = 5
        notificationOffButton.clipsToBounds = true
        notificationOffButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        notificationOffButton.translatesAutoresizingMaskIntoConstraints = false
        return notificationOffButton
    }()
    
    var notificationButtonPresser: Bool = false
    
    //MARK: -Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        setupNavBar()
        
        view.addSubview(greyView)
        view.addSubview(settingsLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(timeFormatLabel)
        view.addSubview(notificationLabel)
        view.addSubview(doneButton)
        view.addSubview(temperatureButton)
        view.addSubview(temperatureFarinheitButton)
        view.addSubview(windMileButton)
        view.addSubview(windKilometersButton)
        view.addSubview(time12Button)
        view.addSubview(time24Button)
        view.addSubview(notificationOnButton)
        view.addSubview(notificationOffButton)
        
        setupConstraints()
        
        //Загружаем данные
        //MARK: -Температура
        if (UserDefaults.standard.object(forKey: "TemperatureFarinheit") != nil) == true {
        
            let valueFarinheit = UserDefaults.standard.colorForKey(key: "TemperatureFarinheit")
            let valueCelsius = UserDefaults.standard.colorForKey(key: "TemperatureCelsius")
            let valueFarinheitText = UserDefaults.standard.colorForKey(key: "TemperatureFarinheitText")
            let valueCelsiusText = UserDefaults.standard.colorForKey(key: "TemperatureCelsiusText")
            temperatureFarinheitButton.backgroundColor = valueFarinheit
            temperatureFarinheitButton.setTitleColor(valueFarinheitText, for: .normal)
            temperatureButton.backgroundColor = valueCelsius
            temperatureButton.setTitleColor(valueCelsiusText, for: .normal)
        }
        
        //MARK: -Скорость ветра
        if (UserDefaults.standard.object(forKey: "WindKilometers") != nil) == true {
        
            let valueKilometers = UserDefaults.standard.colorForKey(key: "WindKilometers")
            let valueMiles = UserDefaults.standard.colorForKey(key: "WindMiles")
            let valueKilometersText = UserDefaults.standard.colorForKey(key: "WindKilometersText")
            let valueMilesText = UserDefaults.standard.colorForKey(key: "WindMilesText")
            windKilometersButton.backgroundColor = valueKilometers
            windKilometersButton.setTitleColor(valueKilometersText, for: .normal)
            windMileButton.backgroundColor = valueMiles
            windMileButton.setTitleColor(valueMilesText, for: .normal)
        }
        
        //MARK: -Формат времени
        if (UserDefaults.standard.object(forKey: "Time24") != nil) == true {
            
            let value24 = UserDefaults.standard.colorForKey(key: "Time24")
            let value12 = UserDefaults.standard.colorForKey(key: "Time12")
            let value24Text = UserDefaults.standard.colorForKey(key: "Time24Text")
            let value12Text = UserDefaults.standard.colorForKey(key: "Time12Text")
            time24Button.backgroundColor = value24
            time24Button.setTitleColor(value24Text, for: .normal)
            time12Button.backgroundColor = value12
            time12Button.setTitleColor(value12Text, for: .normal)
        }
        
        //MARK: -Уведомления
        if (UserDefaults.standard.object(forKey: "NotificationOff") != nil) == true {
            let notificationsOff = UserDefaults.standard.colorForKey(key: "NotificationOff")
            let notificationsOn = UserDefaults.standard.colorForKey(key: "NotificationOn")
            let notificationsOffText = UserDefaults.standard.colorForKey(key: "NotificationOffText")
            let notificationsOnText = UserDefaults.standard.colorForKey(key: "NotificationOnText")
            notificationOffButton.backgroundColor = notificationsOff
            notificationOffButton.setTitleColor(notificationsOffText, for: .normal)
            notificationOnButton.backgroundColor = notificationsOn
            notificationOnButton.setTitleColor(notificationsOnText, for: .normal)
        }
        
    }
        
    
    
    //MARK: -Functions
    
    func setupNavBar() {
        self.navigationController!.navigationBar.isHidden = true
    }
    
    func setupConstraints() {
        
        let constraints = [
        
            greyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            greyView.widthAnchor.constraint(equalToConstant: view.frame.width - 30 * 2),
            greyView.heightAnchor.constraint(equalToConstant: view.frame.height - 100 * 2),
            
            settingsLabel.topAnchor.constraint(equalTo: greyView.topAnchor, constant: 50),
            settingsLabel.leadingAnchor.constraint(equalTo: greyView.leadingAnchor, constant: 30),
            settingsLabel.widthAnchor.constraint(equalToConstant: 100),
            settingsLabel.heightAnchor.constraint(equalToConstant: 30),
            
            temperatureLabel.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: settingsLabel.leadingAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 200),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            
            windSpeedLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            windSpeedLabel.leadingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            windSpeedLabel.widthAnchor.constraint(equalToConstant: 200),
            windSpeedLabel.heightAnchor.constraint(equalToConstant: 30),
            
            timeFormatLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 20),
            timeFormatLabel.leadingAnchor.constraint(equalTo: windSpeedLabel.leadingAnchor),
            timeFormatLabel.widthAnchor.constraint(equalToConstant: 200),
            timeFormatLabel.heightAnchor.constraint(equalToConstant: 30),
            
            notificationLabel.topAnchor.constraint(equalTo: timeFormatLabel.bottomAnchor, constant: 20),
            notificationLabel.leadingAnchor.constraint(equalTo: timeFormatLabel.leadingAnchor),
            notificationLabel.widthAnchor.constraint(equalToConstant: 200),
            notificationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            doneButton.topAnchor.constraint(equalTo: greyView.bottomAnchor, constant: 50),
            doneButton.centerXAnchor.constraint(equalTo: greyView.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 200),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureButton.topAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            temperatureButton.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            temperatureButton.widthAnchor.constraint(equalToConstant: 40),
            temperatureButton.heightAnchor.constraint(equalToConstant: 30),
            
            temperatureFarinheitButton.topAnchor.constraint(equalTo: temperatureLabel.topAnchor),
            temperatureFarinheitButton.leadingAnchor.constraint(equalTo: temperatureButton.trailingAnchor),
            temperatureFarinheitButton.widthAnchor.constraint(equalToConstant: 40),
            temperatureFarinheitButton.heightAnchor.constraint(equalToConstant: 30),
            
            windMileButton.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor),
            windMileButton.leadingAnchor.constraint(equalTo: windSpeedLabel.trailingAnchor),
            windMileButton.widthAnchor.constraint(equalToConstant: 40),
            windMileButton.heightAnchor.constraint(equalToConstant: 30),
            
            windKilometersButton.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor),
            windKilometersButton.leadingAnchor.constraint(equalTo: windMileButton.trailingAnchor),
            windKilometersButton.widthAnchor.constraint(equalToConstant: 40),
            windKilometersButton.heightAnchor.constraint(equalToConstant: 30),
            
            time12Button.topAnchor.constraint(equalTo: timeFormatLabel.topAnchor),
            time12Button.leadingAnchor.constraint(equalTo: timeFormatLabel.trailingAnchor),
            time12Button.widthAnchor.constraint(equalToConstant: 40),
            time12Button.heightAnchor.constraint(equalToConstant: 30),
            
            time24Button.topAnchor.constraint(equalTo: timeFormatLabel.topAnchor),
            time24Button.leadingAnchor.constraint(equalTo: time12Button.trailingAnchor),
            time24Button.widthAnchor.constraint(equalToConstant: 40),
            time24Button.heightAnchor.constraint(equalToConstant: 30),
            
            notificationOnButton.topAnchor.constraint(equalTo: notificationLabel.topAnchor),
            notificationOnButton.leadingAnchor.constraint(equalTo: notificationLabel.trailingAnchor),
            notificationOnButton.widthAnchor.constraint(equalToConstant: 40),
            notificationOnButton.heightAnchor.constraint(equalToConstant: 30),
            
            notificationOffButton.topAnchor.constraint(equalTo: notificationLabel.topAnchor),
            notificationOffButton.leadingAnchor.constraint(equalTo: notificationOnButton.trailingAnchor),
            notificationOffButton.widthAnchor.constraint(equalToConstant: 40),
            notificationOffButton.heightAnchor.constraint(equalToConstant: 30),
    
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: -Selectors
    
    @objc func temperatureButtonTap() {
        temperatureButton.backgroundColor = .blue
        temperatureButton.setTitleColor(.white, for: .normal)
        temperatureFarinheitButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        temperatureFarinheitButton.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки F становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "TemperatureFarinheit")
        //Текст кнопки F становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "TemperatureFarinheitText")
        //Цвет кнопки C становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "TemperatureCelsius")
        //Текст кнопки C становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "TemperatureCelsiusText")
        
    }
    
    @objc func temperatureFarinheitButtonTap() {
        temperatureFarinheitButton.backgroundColor = .blue
        temperatureFarinheitButton.setTitleColor(.white, for: .normal)
        temperatureButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        temperatureButton.setTitleColor(.black, for: .normal)
        
        //Сохраняем данные
        //Цвет кнопки F становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "TemperatureFarinheit")
        //Текст кнопки F становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "TemperatureFarinheitText")
        //Цвет кнопки C становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "TemperatureCelsius")
        //Текст кнопки C становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "TemperatureCelsiusText")
    }
    
    @objc func windMileButtonButtonTap() {
        windMileButton.backgroundColor = .blue
        windMileButton.setTitleColor(.white, for: .normal)
        windKilometersButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        windKilometersButton.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки Km становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "WindKilometers")
        //Текст кнопки Km становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "WindKilometersText")
        //Цвет кнопки Mi становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "WindMiles")
        //Текст кнопки Mi становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "WindMilesText")
    }
    
    @objc func windKilometersButtonTap() {
        windKilometersButton.backgroundColor = .blue
        windKilometersButton.setTitleColor(.white, for: .normal)
        windMileButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        windMileButton.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки Км становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "WindKilometers")
        //Текст кнопки Km становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "WindKilometersText")
        //Цвет кнопки Mi становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "WindMiles")
        //Текст кнопки Mi становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "WindMilesText")
    }
    
    @objc func time12ButtonTap() {
        time12Button.backgroundColor = .blue
        time12Button.setTitleColor(.white, for: .normal)
        time24Button.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        time24Button.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки 24 становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "Time24")
        //Текст кнопки 24 становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "Time24Text")
        //Цвет кнопки 12 становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "Time12")
        //Текст кнопки 12 становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "Time12Text")
    }
    
    @objc func time24ButtonTap() {
        time24Button.backgroundColor = .blue
        time24Button.setTitleColor(.white, for: .normal)
        time12Button.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        time12Button.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки 24 становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "Time24")
        //Текст кнопки 24 становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "Time24Text")
        //Цвет кнопки 12 становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "Time12")
        //Текст кнопки 12 становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "Time12Text")
    }
    
    @objc func notificationOnButtonTap() {
        notificationOnButton.backgroundColor = .blue
        notificationOnButton.setTitleColor(.white, for: .normal)
        notificationOffButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        notificationOffButton.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки Off становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "NotificationOff")
        //Текст кнопки Off становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "NotificationOffText")
        //Цвет кнопки On становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "NotificationOn")
        //Текст кнопки On становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "NotificationOnText")
    }
    
    @objc func notificationOffButtonTap() {
        notificationOffButton.backgroundColor = .blue
        notificationOffButton.setTitleColor(.white, for: .normal)
        notificationOnButton.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        notificationOnButton.setTitleColor(.black, for: .normal)
        
        //Цвет кнопки Off становится синим
        UserDefaults.standard.setColor(color: .blue, forKey: "NotificationOff")
        //Текст кнопки Off становится белым
        UserDefaults.standard.setColor(color: .white, forKey: "NotificationOffText")
        //Цвет кнопки On становится серым
        UserDefaults.standard.setColor(color: UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1), forKey: "NotificationOn")
        //Текст кнопки On становится чёрным
        UserDefaults.standard.setColor(color: .black, forKey: "NotificationOnText")
    }
    
    @objc func doneButtonTap() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var colorReturnded: UIColor?
        if let colorData = data(forKey: key) {
            do {
                if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                    colorReturnded = color
                }
            } catch {
                print("Error UserDefaults")
            }
        }
    return colorReturnded
    }

    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                colorData = data
            } catch {
                print("Error UserDefaults")
            }
        }
        set(colorData, forKey: key)
    }
}

extension UserDefaults {

    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }

}
