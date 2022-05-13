//
//  ViewController.swift
//  Weather tracker
//
//  Created by Misha on 11.11.2021.
//

import UIKit
import Kingfisher
import CoreLocation
import CoreData
import Locksmith
import RealmSwift
 
protocol AddNewCityDelegate: AnyObject {
    func newCityDidSelected(name: String)
}

//MARK: -Realm
class Cities: Object {
    @objc dynamic var city = ""
    @objc dynamic var id = 0
}

class MainScrenenViewController: UIViewController {
    
    let viewModel: GeneralViewModel
    
    let locationViewModel: LocationViewModel
    
    weak var pageViewController: PageViewController?
    
    var currentIndex = 0 {
        didSet {
            mainCollectionView.reloadData()
            todayCollectionView.reloadData()
            weekCollectionView.reloadData()
        }
    }
    
    weak var selectionDelegate: AddNewCityDelegate?
    
    //MARK: -Realm
    let realm = try! Realm()
 
    var newCityDelegate: AddNewCityDelegate?
    
    //MARK: - Views
    
    //UILabel
    var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.textColor = .black
        cityLabel.lineBreakMode = .byWordWrapping
        cityLabel.textAlignment = .center
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    //UIButton left
    var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(settingsButtonTap), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        return settingsButton
    }()
    
    //UIButton right
    var locationButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.addTarget(self, action: #selector(locationButtonTap), for: .touchUpInside)
        settingsButton.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        return settingsButton
    }()
    
    //UIView slider and Scroll View
    var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayWeatherCell.self, forCellWithReuseIdentifier: "sliderCell")
        collectionView.layer.cornerRadius = 15
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    //UILabel 24 hour
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var detauls24Button: UIButton = {
        let detauls24Button = UIButton()
        detauls24Button.addTarget(self, action: #selector(details24ButtonPressed), for: .touchUpInside)
        detauls24Button.setTitle("Подробнее на 24 часа", for: .normal)
        detauls24Button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        detauls24Button.setTitleColor(.black, for: .normal)
        
        detauls24Button.translatesAutoresizingMaskIntoConstraints = false
        return detauls24Button
    }()
    
    //CollectionView 1 day
    var todayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let todayCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        todayCollectionView.register(TwentyFourHoursCollectionViewCell.self, forCellWithReuseIdentifier: "todayCell")
        todayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        todayCollectionView.backgroundColor = .white
        todayCollectionView.showsHorizontalScrollIndicator = false
        return todayCollectionView
    }()
    
    //UILabel everyday track
    let everydayLabel: UILabel = {
        let everydayLabel = UILabel()
        everydayLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        everydayLabel.font = UIFont.boldSystemFont(ofSize: everydayLabel.font.pointSize)
        everydayLabel.text = "Ежедневный прогноз"
        everydayLabel.textColor = .black
        everydayLabel.textAlignment = .center
        everydayLabel.translatesAutoresizingMaskIntoConstraints = false
        return everydayLabel
    }()
    
    //UIButton 25 day
    var twentyFiveDayButton: UIButton = {
        let twentyFiveDayButton = UIButton()
        twentyFiveDayButton.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        twentyFiveDayButton.setTitleColor(.black, for: .normal)
        twentyFiveDayButton.translatesAutoresizingMaskIntoConstraints = false
        return twentyFiveDayButton
    }()
    
    //Bottom Collection view
    var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        bottomCollectionView.register(WeekCollectionViewCell.self, forCellWithReuseIdentifier: "bottomCell")
        bottomCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomCollectionView.showsVerticalScrollIndicator = false
        bottomCollectionView.backgroundColor = .white
        return bottomCollectionView
    }()
    
    let gradientLayer = CAGradientLayer()
    
    //MARK: - Initialization
    
    init(viewModel: GeneralViewModel,
         locationViewModel: LocationViewModel,
         currentIndex: Int
        ) {
        self.viewModel = viewModel
        self.locationViewModel = locationViewModel
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realmCities = realm.objects(Cities.self)
        
        for city in realmCities {
            self.viewModel.userDidSelectNewCity(name: city.city, id: city.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(settingsButton)
        view.addSubview(locationButton)
        view.addSubview(cityLabel)
        view.addSubview(mainCollectionView)
        view.addSubview(detauls24Button)
        view.addSubview(todayCollectionView)
        view.addSubview(weekCollectionView)
        view.addSubview(everydayLabel)
        view.addSubview(twentyFiveDayButton)
        
        let attributeString = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: yourAttributes)
        let twentyFiveDayButtonAttributeString = NSMutableAttributedString(string: "25 дней", attributes: yourAttributes)
        detauls24Button.setAttributedTitle(attributeString, for: .normal)
        twentyFiveDayButton.setAttributedTitle(twentyFiveDayButtonAttributeString, for: .normal)
    
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        todayCollectionView.dataSource = self
        todayCollectionView.delegate = self
        
        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self
        
        setupConstraints()
        
        //Получил текущую локацию
        viewModel.getCurrentLocation { location in
            self.viewModel.fetchData(for: location)
        }
        
        locationViewModel.locationDidChange = {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
            }
        }
        
        viewModel.viewModelForNewCityDidChange = {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
                
            }
        }
        
        viewModel.viewModelDidChange = {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
                
                if self.realm.objects(Cities.self).first == nil {
                    self.cityLabel.text = self.viewModel.weather.first?.now.name
                    
                    guard let firstCity = self.viewModel.weather.first?.now.name else { return }
                    
                    let city = Cities()
                    city.city = firstCity
                    city.id = 0

                    try! self.realm.write {
                        self.realm.add([city])
                    }
                } else {
                    self.cityLabel.text = self.realm.objects(Cities.self)[self.currentIndex].city
                }
            }
        }
        
        locationViewModel.newCityAdded = { city in
            self.viewModel.userDidSelectNewCity(name: city.geoObject.name, id: city.geoObject.name.count)
        }
    }
    
    //MARK: -Functions
    
    func setupConstraints() {
        let constraints = [
            
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            settingsButton.heightAnchor.constraint(equalToConstant: 22),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            locationButton.heightAnchor.constraint(equalToConstant: 22),
            
            cityLabel.heightAnchor.constraint(equalToConstant: 22),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            mainCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            mainCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            detauls24Button.heightAnchor.constraint(equalToConstant: 20),
            detauls24Button.trailingAnchor.constraint(equalTo: mainCollectionView.trailingAnchor, constant: -2),
            detauls24Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 357),
            
            todayCollectionView.topAnchor.constraint(equalTo: detauls24Button.bottomAnchor, constant: 10),
            todayCollectionView.leadingAnchor.constraint(equalTo: mainCollectionView.leadingAnchor, constant: 2),
            todayCollectionView.trailingAnchor.constraint(equalTo: mainCollectionView.trailingAnchor, constant: -2),
            todayCollectionView.heightAnchor.constraint(equalToConstant: 83),
            
            everydayLabel.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            everydayLabel.leadingAnchor.constraint(equalTo: todayCollectionView.leadingAnchor, constant: 2),
            everydayLabel.heightAnchor.constraint(equalToConstant: 30),
            
            twentyFiveDayButton.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            twentyFiveDayButton.trailingAnchor.constraint(equalTo: todayCollectionView.trailingAnchor, constant: -2),
            twentyFiveDayButton.heightAnchor.constraint(equalToConstant: 30),
            
            weekCollectionView.topAnchor.constraint(equalTo: everydayLabel.bottomAnchor, constant: 10),
            weekCollectionView.leadingAnchor.constraint(equalTo: mainCollectionView.leadingAnchor, constant: 2),
            weekCollectionView.trailingAnchor.constraint(equalTo: mainCollectionView.trailingAnchor, constant: -2),
            weekCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func updateLabels(with id: Int) {
        
        currentIndex = id

        if currentIndex == viewModel.weather.count {
                currentIndex = 0
        }
        
        self.cityLabel.text = self.viewModel.weather[self.currentIndex].now.name
        
        self.todayCollectionView.reloadData()
        self.weekCollectionView.reloadData()
    }

    //MARK: - Selectors
    
    //MARK: - UIAlertController
    @objc func locationButtonTap() {
        let alert = UIAlertController(title: "Добавление города", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Введите город"
        }
        
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
            //Получаю значение текстового поля и передаю его в переменную textField
            let textField = alert.textFields?.first
            
            if textField?.text != "" {

                //Передаю значение textField в функцию в качестве параметра
                guard let text = textField?.text else { return }
                self.selectionDelegate?.newCityDidSelected(name: text)
            }
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    //ShowSettingsController
    @objc func settingsButtonTap() {
        let settingsViewController = SettingsViewController()
        let navigationController2 = UINavigationController(rootViewController: settingsViewController)
        navigationController2.modalPresentationStyle = .fullScreen
        present(navigationController2, animated: true, completion: nil)
    }
    
    //Selector for UIPage Controller
    @objc func pageControlTapHandler(sender: UIPageControl) {
        print("123")
    }
    
    @objc func details24ButtonPressed() {
        let dayCityWeatherViewController = DayCityWeatherViewController(viewModel: viewModel, currentIndex: currentIndex)
        let navigationController = UINavigationController(rootViewController: dayCityWeatherViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

//MARK: - Collection
extension MainScrenenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainCollectionView {
            return 1
        } else if collectionView == self.todayCollectionView {
            if currentIndex > viewModel.weather.startIndex {
                return 7
            } else {
                return 7
            }
        } else {
            return viewModel.weekWeather?.weekDate.count ?? 7
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: -Now Cell
        if collectionView == self.mainCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! DayWeatherCell
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let main = viewModel.weather[currentIndex].now.main?.temp {
                    cell.mainTemperatureLabel.text = String(format: "%.0f", main) + "°"
                } else {
                    cell.mainTemperatureLabel.text = "?"
                }
            } else {
                if let main = viewModel.weather.first?.now.main?.temp {
                    cell.mainTemperatureLabel.text = String(format: "%.0f", main) + "°"
                } else {
                    cell.mainTemperatureLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let minTemp = viewModel.weather[currentIndex].now.main?.temp_min {
                    cell.minTemperatureLabel.text = String(format: "%.0f", minTemp) + "°"
                } else {
                    cell.minTemperatureLabel.text = "?"
                }
            } else {
                if let minTemp = viewModel.weather.first?.now.main?.temp_min {
                    cell.minTemperatureLabel.text = String(format: "%.0f", minTemp) + "°"
                } else {
                    cell.minTemperatureLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let maxTemp = viewModel.weather[currentIndex].now.main?.temp_max {
                    cell.maxTemperatureLabel.text = String(format: "%.0f", maxTemp) + "°"
                } else {
                    cell.maxTemperatureLabel.text = "?"
                }
            } else {
                if let maxTemp = viewModel.weather.first?.now.main?.temp_max {
                    cell.maxTemperatureLabel.text = String(format: "%.0f", maxTemp) + "°"
                } else {
                    cell.maxTemperatureLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let description = viewModel.weather[currentIndex].now.weather?[0].description {
                    cell.weatherDescriptionLabel.text = description
                }
                
                if let windSpeed = viewModel.weather[currentIndex].now.wind?.speed {
                    cell.windSpeedLabel.text = String(format: "%.0f", windSpeed) + "м/с"
                } else {
                    cell.windSpeedLabel.text = "?"
                }
            } else {
                if let description = viewModel.weather.first?.now.weather?[0].description {
                    cell.weatherDescriptionLabel.text = description
                }
                
                if let windSpeed = viewModel.weather.first?.now.wind?.speed {
                    cell.windSpeedLabel.text = String(format: "%.0f", windSpeed) + "м/с"
                } else {
                    cell.windSpeedLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let clouds = viewModel.weather[currentIndex].now.clouds?.all {
                    cell.cloudsLabel.text = String(format: "%.0f", clouds)
                } else {
                    cell.cloudsLabel.text = "?"
                }
            } else {
                if let clouds = viewModel.weather.first?.now.clouds?.all {
                    cell.cloudsLabel.text = String(format: "%.0f", clouds)
                } else {
                    cell.cloudsLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let humidity = viewModel.weather[currentIndex].now.main?.humidity {
                    cell.humidityLabel.text = String(format: "%.0f", humidity) + "%"
                } else {
                    cell.humidityLabel.text = "?"
                }
            } else {
                if let humidity = viewModel.weather.first?.now.main?.humidity {
                    cell.humidityLabel.text = String(format: "%.0f", humidity) + "%"
                } else {
                    cell.humidityLabel.text = "?"
                }
            }
            
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                let dateSunrise = viewModel.weather[currentIndex].now.sys?.sunrise
                let formateSunrise = dateSunrise?.getFormattedDate(format: "HH:mm")
                cell.sunrise.text = formateSunrise
                
                let dateSunset = viewModel.weather[currentIndex].now.sys?.sunset
                let formateSunset = dateSunset?.getFormattedDate(format: "HH:mm")
                cell.sunset.text = formateSunset
            } else {
                let dateSunrise = viewModel.weather.first?.now.sys?.sunrise
                let formateSunrise = dateSunrise?.getFormattedDate(format: "HH:mm")
                cell.sunrise.text = formateSunrise
                
                let dateSunset = viewModel.weather.first?.now.sys?.sunset
                let formateSunset = dateSunset?.getFormattedDate(format: "HH:mm")
                cell.sunset.text = formateSunset
            }
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm, EE d MMMM"
            let dateString = dateFormatter.string(from: date)
            
            cell.dateLabel.text = dateString
            
            return cell
        
        // MARK: -TodayCell
        } else if collectionView == self.todayCollectionView {
        
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "todayCell", for: indexPath) as! TwentyFourHoursCollectionViewCell
            
            cellTwo.layer.cornerRadius = 22
            
            //MARK: -Temp
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                let arrayTemp = viewModel.weather[currentIndex].day.list[indexPath.item].main.temp
                cellTwo.mainTemperatureLabel.text = String(format: "%.0f", arrayTemp) + "°"
            } else {
                if let arrayTemp = viewModel.weather.first?.day.list[indexPath.item].main.temp {
                    cellTwo.mainTemperatureLabel.text = String(format: "%.0f", arrayTemp) + "°"
                }
            }
            
            //MARK: -Time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "ru_RU")

            //Array of Dates
            if let time = self.viewModel.weather.first?.day.list[indexPath.item].dtTxt {

                let dateDate = dateFormatter.date(from: time)
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "HH:mm"
                dateFormatter2.locale = Locale(identifier: "ru_RU")
            
                let dateString = dateFormatter2.string(from: dateDate ?? Date())
                cellTwo.timeLabel.text = dateString
            }
            //MARK: -Icon
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex  {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cellTwo.imageView.kf.setImage(with: url) { result in
                            print(result)
                            cellTwo.setNeedsLayout()
                        }
                    }
            } else {
                if let icon = viewModel.weather.first?.week.daily[indexPath.item].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            cellTwo.imageView.kf.setImage(with: url) { result in
                                cellTwo.setNeedsLayout()
                            }
                        }
            }
            
        return cellTwo
        
        } else {
        //MARK: -WeekWeather
        let cellThree = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as! WeekCollectionViewCell
            
            //MARK: -Date
            
            if let dateInt = viewModel.weather.first?.week.daily[indexPath.item].dt {
                let timeInterval = TimeInterval(dateInt)
                let myNSDate = Date(timeIntervalSince1970: timeInterval)
                    
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "dd/MM"
                dateFormatter2.locale = Locale(identifier: "ru_RU")
                let dateString = dateFormatter2.string(from: myNSDate)
                
                cellThree.dateTemperatureLabel.text = dateString
            
            } 
          
            //MARK: -Icon
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cellThree.weatherImageView.kf.setImage(with: url) { result in
                            print(result)
                            cellThree.setNeedsLayout()
                        }
                    }
            } else {
                if let icon = viewModel.weather.first?.week.daily[indexPath.item].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            cellThree.weatherImageView.kf.setImage(with: url) { result in
                                print(result)
                                cellThree.setNeedsLayout()
                            }
                        }
            }
            
            //MARK: -Rain
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex  {
                if let arrayRain = viewModel.weather[currentIndex].week.daily[indexPath.item].rain {
                    cellThree.rainLabel.text = String(format: "%.0f", arrayRain) + "%"
                }
            } else if let arrayRain = viewModel.weather.first?.week.daily[indexPath.item].rain {
                    cellThree.rainLabel.text = String(format: "%.0f", arrayRain) + "%"
                }
             else if viewModel.weather.first?.week.daily[indexPath.item].rain == nil {
                cellThree.rainLabel.text = "0%"
            }
            
            //MARK: -Description
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex  {
                let weatherDescription = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].description
                cellThree.weatherDescriptionLabel.text = weatherDescription
            } else {
                let weatherDescription = viewModel.weather.first?.week.daily[indexPath.item].weather[0].description
                cellThree.weatherDescriptionLabel.text = weatherDescription
            }
            
            //MARK: -minTemp
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex  {
            
                if let minTemp = viewModel.weather[currentIndex].week.daily[indexPath.row].temp.min {
                let minTempString = String(format: "%.0f", minTemp)
                
                cellThree.minTemperatureLabel.text = "\(minTempString)" + "°" + "..."
                }
            } else {
                
                if let minTemp = viewModel.weather.first?.week.daily[indexPath.row].temp.min {
                let minTempString = String(format: "%.0f", minTemp)
                
                cellThree.minTemperatureLabel.text = "\(minTempString)" + "°" + "..."
                }
            }
            
            //MARK: -maxTemp
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex  {
            
                if let maxTemp = viewModel.weather[currentIndex].week.daily[indexPath.row].temp.max {
                    let maxTempString = String(format: "%.0f", maxTemp)
                
                    cellThree.maxTemperatureLabel.text = "\(maxTempString)" + "°"
                }
            } else {
                
                if let maxTemp = viewModel.weather.first?.week.daily[indexPath.row].temp.max {
                    let maxTempString = String(format: "%.0f", maxTemp)
                
                    cellThree.maxTemperatureLabel.text = "\(maxTempString)" + "°"
                }
            }
            
        return cellThree
        }
    }
    
}

//MARK: -Extensions
extension MainScrenenViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.weekCollectionView {
            let weekCityWeatherViewController = WeekCityWeatherViewController(viewModel: viewModel, currentIndex: currentIndex)
            
            let navigationController3 = UINavigationController(rootViewController: weekCityWeatherViewController)
            navigationController3.modalPresentationStyle = .fullScreen
            present(navigationController3, animated: true)
        }
    }
}

extension MainScrenenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mainCollectionView {
            return CGSize(width: view.frame.width, height: view.frame.height)
        } else if collectionView == self.todayCollectionView {
            return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 56)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.mainCollectionView {
            return 0
        } else if collectionView == self.todayCollectionView {
            return 4
        } else {
            return 4
        }
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension Double {
    func isInteger() -> Any {
        let check = floor(self) == self
        if check {
            return Int(self)
        } else {
            return self
        }
    }
}



