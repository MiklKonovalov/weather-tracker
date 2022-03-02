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
 
//MARK: -Realm

class Cities: Object {
    @objc dynamic var city = ""
}

class MainScrenenViewController: UIViewController {
    
    let viewModel: GeneralViewModel
    
    let locationViewModel: LocationViewModel
    
    var currentIndex = 0
    
    //MARK: -Realm
    let realm = try! Realm()
 
    //MARK: -CoreData
    
    var cities = [CitiesMemory?]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
            }
        }
    }
    
    var cityNames = [String]()
    
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
    
    //UIPage Controller
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
        return pageControl
    }()
    
    //UIView slider and Scroll View
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DayWeatherCell.self, forCellWithReuseIdentifier: "sliderCell")
        collectionView.layer.cornerRadius = 15
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
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
        //twentyFiveDayButton.setTitle("25 дней", for: .normal)
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
    
    init(viewModel: GeneralViewModel, locationViewModel: LocationViewModel) {
        self.viewModel = viewModel
        self.locationViewModel = locationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realmCities = realm.objects(Cities.self)
        
        for city in realmCities {
            self.viewModel.userDidSelectNewCity(name: city.city)
        }
        
        
//        let dictionary = UserDefaults.standard.object(forKey: "Cities") as! [String]
//        print(dictionary)
//
//        if dictionary != nil {
//            for (value) in dictionary {
//                self.viewModel.userDidSelectNewCity(name: value)
//            }
//        }
        
//        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "Weather")
//
//        print(dictionary)
//
//        if dictionary != nil {
//            for (_, value) in dictionary ?? [:] {
//                self.viewModel.userDidSelectNewCity(name: value as! String)
//            }
//        }
    
        
        //Загружаем дату из Keychain
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<CitiesMemory> = CitiesMemory.fetchRequest()
//
//        do {
//            self.cities = try context.fetch(fetchRequest)
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                    self.todayCollectionView.reloadData()
//                    self.weekCollectionView.reloadData()
//                }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(settingsButton)
        view.addSubview(locationButton)
        view.addSubview(cityLabel)
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(detauls24Button)
        view.addSubview(todayCollectionView)
        view.addSubview(weekCollectionView)
        view.addSubview(everydayLabel)
        view.addSubview(twentyFiveDayButton)
        
        let attributeString = NSMutableAttributedString(string: "Подробнее на 24 часа", attributes: yourAttributes)
        let twentyFiveDayButtonAttributeString = NSMutableAttributedString(string: "25 дней", attributes: yourAttributes)
        detauls24Button.setAttributedTitle(attributeString, for: .normal)
        twentyFiveDayButton.setAttributedTitle(twentyFiveDayButtonAttributeString, for: .normal)
    
        collectionView.dataSource = self
        collectionView.delegate = self
        
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
                self.collectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
            }
        }
        
        viewModel.viewModelForNewCityDidChange = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
                
            }
        }
        
        viewModel.viewModelDidChange = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.todayCollectionView.reloadData()
                self.weekCollectionView.reloadData()
                self.cityLabel.text = self.viewModel.weather[self.currentIndex].now.name
            }
        }
        
        locationViewModel.newCityAdded = { city in
            self.viewModel.userDidSelectNewCity(name: city.geoObject.name)
        }
        
        //Получено текущее местоположение
        locationViewModel.locationDidLoad()
        locationViewModel.newLocationDidLoad()
        
    }
    
    //MARK: -Functions
    
    func setupConstraints() {
        
        let constraints = [
        
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            settingsButton.heightAnchor.constraint(equalToConstant: 22),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            locationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            locationButton.heightAnchor.constraint(equalToConstant: 22),
            
            cityLabel.heightAnchor.constraint(equalToConstant: 22),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            
            collectionView.widthAnchor.constraint(equalToConstant: 344),
            collectionView.heightAnchor.constraint(equalToConstant: 212),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 112),
            
            pageControl.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detauls24Button.heightAnchor.constraint(equalToConstant: 20),
            detauls24Button.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            detauls24Button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 357),
            
            todayCollectionView.topAnchor.constraint(equalTo: detauls24Button.bottomAnchor, constant: 10),
            todayCollectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            todayCollectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            todayCollectionView.heightAnchor.constraint(equalToConstant: 83),
            
            everydayLabel.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            everydayLabel.leadingAnchor.constraint(equalTo: todayCollectionView.leadingAnchor),
            everydayLabel.heightAnchor.constraint(equalToConstant: 30),
            
            twentyFiveDayButton.topAnchor.constraint(equalTo: todayCollectionView.bottomAnchor, constant: 10),
            twentyFiveDayButton.trailingAnchor.constraint(equalTo: todayCollectionView.trailingAnchor),
            twentyFiveDayButton.heightAnchor.constraint(equalToConstant: 30),
            
            weekCollectionView.topAnchor.constraint(equalTo: everydayLabel.bottomAnchor, constant: 10),
            weekCollectionView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            weekCollectionView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            weekCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        let currentPage = Int(offSet + horizontalCenter) / Int(width)
        
        if !decelerate {
            updateLabels(with: currentPage)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        let currentPage = Int(offSet + horizontalCenter) / Int(width)
        
        if currentPage != currentIndex {
            updateLabels(with: currentPage)
        }
        
    }
    
    func updateLabels(with index: Int) {
        
        currentIndex = index

        if currentIndex == viewModel.weather.count {
                currentIndex = 0
        }
        
        self.cityLabel.text = self.viewModel.weather[self.currentIndex].now.name
        
        self.todayCollectionView.reloadData()
        self.weekCollectionView.reloadData()
    }
    
    //MARK: -CoreData
    func saveCities(title: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let persistanceConteiner = appDelegate.persistentContainer
        
        func newBackgroundContext() -> NSManagedObjectContext {
            return persistanceConteiner.newBackgroundContext()
        }
        
        //Переносим в фоновый поток
        let context = newBackgroundContext()
        
        //Создаём объект
        context.perform {
            let citiesMemory = CitiesMemory(context: context)
            citiesMemory.title = title
            //Сохраняем данные
            do {
                try context.save()
                self.cityNames.append(title)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCities() {

        let fetchRequest: NSFetchRequest<CitiesMemory> = CitiesMemory.fetchRequest()
        let city = title
        let predicate = NSPredicate(format: "%K = %@", #keyPath(CitiesMemory.title))
        fetchRequest.predicate = predicate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        context.perform {
            do {
                let result = try context.fetch(fetchRequest)
                self.cities = result
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
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
                
                self.viewModel.userDidSelectNewCity(name: text)
            
                //Сохраняем данные в Realm
                let city = Cities()
                city.city = text
                
                try! self.realm.write {
                    self.realm.add([city])
                }
                
    
                
                //Сохраняем данные в Keychain
                //self.cityNames.append(text)
                
                //print(self.cityNames)
                
                //Сохраняем данные в UserDefaults
                //UserDefaults.standard.set(self.cityNames, forKey: "Cities")
//                do {
//                    try Locksmith.saveData(data: ["City" : text], forUserAccount: "Weather")
//                } catch {
//                    print("Не получается сохранить город")
//                }
                
                //self.saveCities(title: text)
                
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
        if collectionView == self.collectionView {
            return viewModel.weather.count
        } else if collectionView == self.todayCollectionView {
            //currentIndex - это количество имеющихся городов. При загрузке приложения этот индекс = 0, так как у нас есть 1 город. Если при загрузке информация ещё не загрузилась, то мы покажем 7 ячеек
            if currentIndex != 0 {
                //Я хочу показать количество ячеек равное 7 и в list их 7
                return viewModel.weather[currentIndex].day.list.count
            } else {
                return 7
            }
        } else {
            return viewModel.weekWeather?.weekDate.count ?? 7
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: -Now Cell
        if collectionView == self.collectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! DayWeatherCell
             
            if let main = viewModel.weather[indexPath.item].now.main?.temp {
                cell.mainTemperatureLabel.text = String(format: "%.0f", main) + "°"
            } else {
                cell.mainTemperatureLabel.text = "?"
            }
            
            if let minTemp = viewModel.weather[indexPath.item].now.main?.temp_min {
                cell.minTemperatureLabel.text = String(format: "%.0f", minTemp) + "°"
            } else {
                cell.minTemperatureLabel.text = "?"
            }
            
            if let maxTemp = viewModel.weather[indexPath.item].now.main?.temp_max {
                cell.maxTemperatureLabel.text = String(format: "%.0f", maxTemp) + "°"
            } else {
                cell.maxTemperatureLabel.text = "?"
            }
            
            if let description = viewModel.weather[indexPath.item].now.weather?[0].description {
                cell.weatherDescriptionLabel.text = description
            }
            
            if let windSpeed = viewModel.weather[indexPath.item].now.wind?.speed {
                cell.windSpeedLabel.text = String(format: "%.0f", windSpeed) + "м/с"
            } else {
                cell.windSpeedLabel.text = "?"
            }
            
            if let clouds = viewModel.weather[indexPath.item].now.clouds?.all {
                cell.cloudsLabel.text = String(format: "%.0f", clouds)
            } else {
                cell.cloudsLabel.text = "?"
            }
            
            if let humidity = viewModel.weather[indexPath.item].now.main?.humidity {
                cell.humidityLabel.text = String(format: "%.0f", humidity) + "%"
            } else {
                cell.humidityLabel.text = "?"
            }
            
            let dateSunrise = viewModel.weather[indexPath.item].now.sys?.sunrise
            let formateSunrise = dateSunrise?.getFormattedDate(format: "HH:mm")
            cell.sunrise.text = formateSunrise
            
            let dateSunset = viewModel.weather[indexPath.item].now.sys?.sunset
            let formateSunset = dateSunset?.getFormattedDate(format: "HH:mm")
            cell.sunset.text = formateSunset
            
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
            
            //Проверим, есть ли в viewModel.weather значения. Если значений нет, то покажем первый элемент массива?
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                let arrayTemp = viewModel.weather[currentIndex].day.list[indexPath.item].main.temp
                cellTwo.mainTemperatureLabel.text = String(format: "%.0f", arrayTemp) + "°"
            } else {
                let arrayTemp = viewModel.weather.first?.day.list[indexPath.item].main.temp
                cellTwo.mainTemperatureLabel.text = String(format: "%.0f", arrayTemp!) + "°"
            }
            
            //MARK: -Time
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "ru_RU")

            //Array of Dates
            if let time = self.viewModel.weather.first?.day.list[indexPath.item].dtTxt {
            //12:00 , 15:00
                let dateDate = dateFormatter.date(from: time)
                //09:00, 12:00
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "HH:mm"
                dateFormatter2.locale = Locale(identifier: "ru_RU")
            
                let dateString = dateFormatter2.string(from: dateDate ?? Date())
                //12:00 , 15:00
                cellTwo.timeLabel.text = dateString
                
//                //Текущая дата
//                let date = Date()
//                //10:00 (берётся среднеевропейское время)
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier: "ru_RU")
//                dateFormatter.dateFormat = "HH:mm"
//                let dateStringForBlueColor = dateFormatter.string(from: date)
//                //13:10
//                let splits = dateString.split(separator: ":").map(String.init)
//
//                let hour = ((splits[0]) as NSString).intValue
//
//                let timeValue = hour / hour
                if indexPath.item == 1 {
                    cellTwo.backgroundColor = UIColor.blue
                    cellTwo.timeLabel.textColor = UIColor.white
                    cellTwo.mainTemperatureLabel.textColor = UIColor.white
                }
            
            }
            //MARK: -Icon
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cellTwo.imageView.kf.setImage(with: url) { result in
                            print(result)
                            cellTwo.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                    if let icon = viewModel.weather.first?.week.daily[indexPath.item].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            cellTwo.imageView.kf.setImage(with: url) { result in
                                print(result)
                                cellTwo.setNeedsLayout()
                            }
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
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cellThree.weatherImageView.kf.setImage(with: url) { result in
                            print(result)
                            cellThree.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                    if let icon = viewModel.weather.first?.week.daily[indexPath.item].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            cellThree.weatherImageView.kf.setImage(with: url) { result in
                                print(result)
                                cellThree.setNeedsLayout()
                            }
                        }
                }
            }
            
            //MARK: -Rain
            if currentIndex > 0 {
                if let arrayRain = viewModel.weather[currentIndex].week.daily[indexPath.item].rain {
                    cellThree.rainLabel.text = String(format: "%.0f", arrayRain)
                }
            } else {
                if let arrayRain = viewModel.weather.first?.week.daily[indexPath.item].rain {
                cellThree.rainLabel.text = String(format: "%.0f", arrayRain)
                }
            }
            
            //MARK: -Description
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                let weatherDescription = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].description
                cellThree.weatherDescriptionLabel.text = weatherDescription
            } else {
                let weatherDescription = viewModel.weather.first?.week.daily[indexPath.item].weather[0].description
                cellThree.weatherDescriptionLabel.text = weatherDescription
            }
            
            //MARK: -minTemp
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            
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
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            
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
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == self.todayCollectionView {
            return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: 56)
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



