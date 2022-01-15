//
//  ViewController.swift
//  Weather tracker
//
//  Created by Misha on 11.11.2021.
//

import UIKit
import Kingfisher
import CoreLocation

class MainScrenenViewController: UIViewController {
    
    let viewModel: GeneralViewModel
    
    let locationViewModel: LocationViewModel
    
    //var processJson: ((LocationData) -> Void)?
    
    //var cityArray = [(LocationDatum)?]()
    
    var currentIndex = 0
    
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
        twentyFiveDayButton.addTarget(self, action: #selector(twentyFiveDayButtonPressed), for: .touchUpInside)
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
        bottomCollectionView.backgroundColor = .white
        return bottomCollectionView
    }()
    
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
            self.viewModel.userDidSelectNewCity(name: city.name)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateLabels()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateLabels()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateLabels()
        }
    }
    
    func updateLabels() {
        
        currentIndex += 1

        if currentIndex == viewModel.weather.count {
                currentIndex = 0
        }
        
        self.cityLabel.text = self.viewModel.weather[currentIndex].now.name
        
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
                self.viewModel.userDidSelectNewCity(name: text) //Передали название города
                print(self.viewModel.weather.count)
            }
            
        })
        
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    //ShowSettingsController
    @objc func settingsButtonTap() {
        print("123")
    }
    
    //Selector for UIPage Controller
    @objc func pageControlTapHandler(sender: UIPageControl) {
        print("123")
    }
    
    @objc func details24ButtonPressed() {
        let dayCityWeatherViewController = DayCityWeatherViewController(viewModel: viewModel, currentIndex: currentIndex)
        present(dayCityWeatherViewController, animated: true, completion: nil)
    }
    
    @objc func twentyFiveDayButtonPressed() {
        
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
             
            if let main: String? = String(format: "%.0f",viewModel.weather[indexPath.item].now.main?.temp ?? 1.1) {
                cell.mainTemperatureLabel.text = "\(main ?? "No data") °"
            }
            
            if let minTemp: String? = String(format: "%.0f", viewModel.weather[indexPath.item].now.main?.temp_min ?? 1.1) {
                cell.minTemperatureLabel.text = "\(minTemp ?? "No data") °"
            }
            
            if let maxTemp: String? = String(format: "%.0f", viewModel.weather[indexPath.item].now.main?.temp_max ?? 1.1) {
                cell.maxTemperatureLabel.text = "\(maxTemp ?? "No data") °"
            }
            
            if let description = viewModel.weather[indexPath.item].now.weather?[0].main {
                cell.weatherDescriptionLabel.text = description
            }
            
            if let windSpeed: String? = String(format: "%.0f", viewModel.weather[indexPath.item].now.wind?.speed ?? 1.1) {
                cell.windSpeedLabel.text = "\(windSpeed ?? "No data") м/с"
            }
            
            if let clouds: String? = String(viewModel.weather[indexPath.item].now.clouds?.all ?? 1) {
                cell.cloudsLabel.text = clouds
            }
            
            if let humidity: String? = String(viewModel.weather[indexPath.item].now.main?.humidity ?? 1) {
                cell.humidityLabel.text = "\(humidity ?? "No data") %"
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
            
            //MARK: -Temp
            
            //Проверим, есть ли в viewModel.weather значения. Если значений нет, то покажем первый элемент массива?
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let arrayTemp: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].main.temp ?? 1.1) {
                    cellTwo.mainTemperatureLabel.text = "\(arrayTemp ?? "No data")" + " " + "°"
                }
            } else {
                if let arrayTemp: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].main.temp ?? 1.1) {
                    cellTwo.mainTemperatureLabel.text = "\(arrayTemp ?? "No data")" + " " + "°"
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
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cellTwo.imageView.kf.setImage(with: url) { result in
                            print(result)
                            cellTwo.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
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
                if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
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
            
            if let arrayRain = viewModel.weather.first?.week.daily[indexPath.item].rain {
                let arrayRainString = String(format: "%.0f", arrayRain)
                cellThree.rainLabel.text = arrayRainString
            }
            
            //MARK: -Description
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
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
            let weekCityWeatherViewController = WeekCityWeatherViewController()
            navigationController?.present(weekCityWeatherViewController, animated: true, completion: nil)
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



