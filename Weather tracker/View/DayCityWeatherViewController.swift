//
//  DayCityWeatherViewController.swift
//  Weather tracker
//
//  Created by Misha on 17.11.2021.
//

import Foundation
import UIKit
import Kingfisher

class DayCityWeatherViewController: UIViewController {
    
    //MARK: -Properties
    
    let viewModel: GeneralViewModel
    
    let locationViewModel = LocationViewModel(
        locationService: LocationManager(),
        locationGroup: LocationGroup())
    
    let tableview: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        tableview.separatorColor = UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    var currentIndex: Int
    
    //Arrow Button
    var arrowButton: UIButton = {
        let arrowButton = UIButton()
        arrowButton.addTarget(self, action: #selector(arrowButtonTap), for: .touchUpInside)
        arrowButton.setImage(#imageLiteral(resourceName: "leftarrow"), for: .normal)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        return arrowButton
    }()
    
    //Title of controller
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        titleLabel.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        titleLabel.text = "Прогноз на 24 часа"
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    //CityLabel
    var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        cityLabel.textColor = .black
        cityLabel.lineBreakMode = .byWordWrapping
        cityLabel.textAlignment = .left
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    //BlueView
    var blueView: UIView = {
        let blueView = UIView()
        blueView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        blueView.translatesAutoresizingMaskIntoConstraints = false
        return blueView
    }()
    
    let shapeLayer = CAShapeLayer()
    
    //Diagonal
    var diagonalView: UIView = {
        let diagonalView = UIView()
        //diagonalView.backgroundColor = .clear
        diagonalView.translatesAutoresizingMaskIntoConstraints = false
        return diagonalView
    }()
    
    //View for blur
    var viewForBlur: UIView = {
        let viewForBlur = UIView()
        viewForBlur.backgroundColor = .blue
        viewForBlur.translatesAutoresizingMaskIntoConstraints = false
        return viewForBlur
    }()
    
    //Blur View
    var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.clipsToBounds = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()

    var iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IconDayWeatherScreenCell.self, forCellWithReuseIdentifier: "iconAndHumidityCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        return collectionView
    }()
    
    var lineView: UIView = {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    var timeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TimeDayWeatherScreenCell.self, forCellWithReuseIdentifier: "timeCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        return collectionView
    }()
    
    //MARK: -Selectors
    
    @objc func arrowButtonTap() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -Inizializations
    init(viewModel: GeneralViewModel, currentIndex: Int) {
        self.viewModel = viewModel
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tableview.deselectSelectedRow(animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(arrowButton)
        view.addSubview(titleLabel)
        view.addSubview(cityLabel)
        view.addSubview(blueView)
        view.addSubview(viewForBlur)
        view.addSubview(blurView)
        view.addSubview(iconCollectionView)
        view.addSubview(timeCollectionView)
        
        tableview.register(OneTableWeatherScreenCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(tableview)
        
        
        iconCollectionView.dataSource = self
        iconCollectionView.delegate = self
        
        timeCollectionView.dataSource = self
        timeCollectionView.delegate = self
        
        tableview.dataSource = self
        tableview.delegate = self
        
        setupConstraints()
        
        setupNavBar()
        
        cityLabel.text = viewModel.weather[currentIndex].now.name
        
        let diagonalView = DiagonalView(frame: CGRect(x: 30, y: 200, width: 350, height: 50))
        self.view.addSubview(diagonalView)
        diagonalView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        blurView.effect = blurEffect

        let lineView = LineView(frame: CGRect(x: 30, y: 260, width: view.frame.width - 60, height: 10)) //Можно ли это разместить констрейнтом?
        self.view.addSubview(lineView)
        lineView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        
    }
    
    //MARK: -Functions
    
    func setupConstraints() {
        
        let constraints = [
        
            arrowButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            arrowButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            arrowButton.widthAnchor.constraint(equalToConstant: 20),
            arrowButton.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            titleLabel.leadingAnchor.constraint(equalTo: arrowButton.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0),
            cityLabel.heightAnchor.constraint(equalToConstant: 20),
            cityLabel.widthAnchor.constraint(equalToConstant: 200),
            
            blueView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            blueView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            blueView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            blueView.heightAnchor.constraint(equalToConstant: 200),
            
//            blurView.centerXAnchor.constraint(equalTo: blueView.centerXAnchor),
//            blurView.centerYAnchor.constraint(equalTo: blueView.centerYAnchor),
//            blurView.widthAnchor.constraint(equalToConstant: 300),
//            blurView.heightAnchor.constraint(equalToConstant: 50),
//            
//            viewForBlur.centerXAnchor.constraint(equalTo: blueView.centerXAnchor),
//            viewForBlur.centerYAnchor.constraint(equalTo: blueView.centerYAnchor),
//            viewForBlur.widthAnchor.constraint(equalToConstant: 250),
//            viewForBlur.heightAnchor.constraint(equalToConstant: 15),
            
            iconCollectionView.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 80),
            iconCollectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 25),
            iconCollectionView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -25),
            iconCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            timeCollectionView.topAnchor.constraint(equalTo: iconCollectionView.bottomAnchor, constant: 30),
            timeCollectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 0),
            timeCollectionView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: 0),
            timeCollectionView.heightAnchor.constraint(equalToConstant: 30),
            
            tableview.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 50),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupNavBar() {
        
        self.navigationController!.navigationBar.isHidden = true
    }
}

//MARK: -Triangle with dashed

class DiagonalView : UIView {
    override func draw(_ rect: CGRect) {
        //Линия
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 10, y:0))
        line.addLine(to: CGPoint(x: 60, y:5))
        line.addLine(to: CGPoint(x: 110, y:10))
        line.addLine(to: CGPoint(x: 160, y:15))
        line.addLine(to: CGPoint(x: 210, y:20))
        line.addLine(to: CGPoint(x: 260, y:25))
        line.addLine(to: CGPoint(x: 310, y:30))
        line.lineWidth = 2
        line.stroke()

        //Точки
        UIColor.white.setFill()

        let origins = [CGPoint(x: 10, y: 0),
                       CGPoint(x: 60, y: 5),
                       CGPoint(x: 110, y: 10),
                       CGPoint(x: 160, y: 15),
                       CGPoint(x: 210, y: 20),
                       CGPoint(x: 260, y: 25),
                       CGPoint(x: 310, y: 30),]

        let size = CGSize(width: 8, height: 8)

        for origin in origins {
            let quad = UIBezierPath.init(roundedRect: CGRect(origin: origin, size: size), cornerRadius: 5)
            quad.fill()
            quad.stroke()
        }
        //Пунктирная линия
        let  path = UIBezierPath()
        
        let  p0 = CGPoint(x: 10, y: 0)
        path.move(to: p0)

        let  p1 = CGPoint(x: 10, y: 35)
        path.addLine(to: p1)
        
        let  p2 = CGPoint(x: 310, y: 35)
        path.addLine(to: p2)

        let  dashes: [ CGFloat ] = [ 10.0, 10.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineWidth = 2.0
        path.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        path.stroke()
        
        //Треугольник
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 0, y: 200))
        trianglePath.addLine(to: CGPoint(x: 100, y: 0))
        trianglePath.addLine(to: CGPoint(x: 200, y: 200))
        trianglePath.addLine(to: CGPoint(x: 0, y: 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 3
    }
}

//MARK: -Line

class LineView : UIView {
    override func draw(_ rect: CGRect) {
        //Линия
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 10, y:0))
        line.addLine(to: CGPoint(x: 60, y:0))
        line.addLine(to: CGPoint(x: 110, y:0))
        line.addLine(to: CGPoint(x: 160, y:0))
        line.addLine(to: CGPoint(x: 210, y:0))
        line.addLine(to: CGPoint(x: 260, y:0))
        line.addLine(to: CGPoint(x: 310, y:0))
        line.lineWidth = 2
        line.stroke()

        //Точки
        UIColor.white.setFill()

        let origins = [CGPoint(x: 10, y: 0),
                       CGPoint(x: 60, y: 0),
                       CGPoint(x: 110, y: 0),
                       CGPoint(x: 160, y: 0),
                       CGPoint(x: 210, y: 0),
                       CGPoint(x: 260, y: 0),
                       CGPoint(x: 310, y: 0),]

        let size = CGSize(width: 8, height: 8)

        for origin in origins {
            let quad = UIBezierPath.init(roundedRect: CGRect(origin: origin, size: size), cornerRadius: 5)
            quad.fill()
            quad.stroke()
        }
    }
}

//MARK: -Collection

extension DayCityWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.iconCollectionView {
            return 7
        } else if collectionView == self.timeCollectionView {
            return 7
        } else {
            return 7
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.iconCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconAndHumidityCell", for: indexPath) as! IconDayWeatherScreenCell
            
            //MARK: -Icon
            if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cell.imageView.kf.setImage(with: url) { result in
                            cell.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
                    if let icon = viewModel.weather.first?.week.daily[indexPath.item].weather[0].icon {
                        let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                            let url = URL(string: urlStr)
                            cell.imageView.kf.setImage(with: url) { result in
                                print(result)
                                cell.setNeedsLayout()
                            }
                        }
                }
        }
        
        //MARK: -Humidity
        
        if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            if let humidity: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].main.humidity ?? 1.1) {
                cell.humidityLabel.text = "\(humidity ?? "No data")" + " " + "%"
            }
        } else {
            if let humidity: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].main.humidity ?? 1.1) {
                cell.humidityLabel.text = "\(humidity ?? "No data")" + " " + "%"
                print(humidity)
                }
            
        }
        
            return cell
            
        } else {
            
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "timeCell", for: indexPath) as! TimeDayWeatherScreenCell
            
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
        return cellTwo
    }
}
}

extension DayCityWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.iconCollectionView {
            return CGSize(width: collectionView.frame.width / 9, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width / 9, height: collectionView.frame.height)
        }
    }
}

//MARK: -Table

extension DayCityWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! OneTableWeatherScreenCell
        cell.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        //MARK: -Date
            
        let date = Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = Locale(identifier: "ru_RU")
        dateFormatter2.dateFormat = "E dd/MM"
        let dateString = dateFormatter2.string(from: date)
        
        cell.dateLabel.text = dateString
        
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
    
            cell.timeLabel.text = dateString
        
        }
        
        //MARK: -Temp

        if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            if let arrayTemp: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].main.temp ?? 1.1) {
                cell.tempLabel.text = "\(arrayTemp ?? "No data")" + " " + "°"
            }
        } else {
            if let arrayTemp: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].main.temp ?? 1.1) {
                cell.tempLabel.text = "\(arrayTemp ?? "No data")" + " " + "°"
                }
            
        }
        
        //MARK: -Descriptions
        cell.windDescriptionLabel.text = "Ветер"
        cell.rainDescriptionLabel.text = "Атмосферные осадки"
        cell.cloudsDescriptionLabel.text = "Облачность"
        
        //MARK: -Wind Value
        if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            if let wind: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].wind.speed ?? 1.1) {
                cell.windValueLabel.text = "\(wind ?? "No data")" + " " + "m/s"
            }
        } else {
            if let wind: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].wind.speed ?? 1.1) {
                cell.windValueLabel.text = "\(wind ?? "No data")" + " " + "m/s"
            }
            
        }
        
        //MARK: -Rain Value
        if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            if let rain: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].rain?.the3H ?? 1.1) {
                cell.rainValueLabel.text = "\(rain ?? "No data")" + " " + "%"
            }
        } else {
            if let rain: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].rain?.the3H ?? 1.1) {
                cell.rainValueLabel.text = "\(rain ?? "No data")" + " " + "%"
            }
            
        }
        
        //MARK: -Cloud Value
        if currentIndex > viewModel.weather.startIndex && currentIndex < viewModel.weather.endIndex {
            if let cloud: String? = String(format: "%.0f",viewModel.weather[currentIndex].day.list[indexPath.item].clouds.all ?? 1.1) {
                cell.cloudsValueLabel.text = "\(cloud ?? "No data")" + " " + "%"
            }
        } else {
            if let cloud: String? = String(format: "%.0f",viewModel.weather.first?.day.list[indexPath.item].clouds.all ?? 1.1) {
                cell.cloudsValueLabel.text = "\(cloud ?? "No data")" + " " + "%"
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
}

extension DayCityWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension UITableView {

    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}

