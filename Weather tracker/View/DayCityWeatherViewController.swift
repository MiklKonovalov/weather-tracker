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
    
    let gradientLayer = CAGradientLayer()
    
    let mask = CAShapeLayer()
    
    //MARK: -Selectors
    
    @objc func arrowButtonTap() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK: -Initializations
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
        
        let diagonalView = DiagonalView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 50))
        blueView.addSubview(diagonalView)
        diagonalView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        let lineView = LineView(frame: CGRect(x: 0, y: 160, width: view.frame.width, height: 10)) //Можно ли это разместить констрейнтом?
        blueView.addSubview(lineView)
        lineView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        //Создаём простую прямоугольную вью с градиентом
        let triangleView = TriangleView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 50))
        self.view.addSubview(triangleView)
        //Устанавливаем градиент (и, соотетственно, цвет)
        gradientLayer.frame = triangleView.bounds
        gradientLayer.colors = [UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1).cgColor, UIColor.blue.cgColor, UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1).cgColor]
        triangleView.layer.insertSublayer(gradientLayer, at: 0)
        
        //Создаём вью с треугольников (фон - прозрачный, треугольник - синий)
        let maskTriangleView = MaskTriangleView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 50))
        self.view.addSubview(maskTriangleView)
        //Устанавливаем маску. Ожидаю, что треугольник перетянет на себя градиент
        gradientLayer.mask = maskTriangleView.layer
        
        let tempValuesView = TempValuesView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100), viewModel: viewModel, currentIndex: currentIndex)
        blueView.addSubview(tempValuesView)
        tempValuesView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
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
            blueView.heightAnchor.constraint(equalToConstant: 230),
            
            iconCollectionView.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 100),
            iconCollectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 10),
            iconCollectionView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10),
            iconCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            timeCollectionView.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 170),
            timeCollectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 10),
            timeCollectionView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -10),
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

//MARK: -Пунктирный треугольник

class DiagonalView : UIView {
    override func draw(_ rect: CGRect) {
        //Диагональная линия
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 10, y:0))
//        line.addLine(to: CGPoint(x: frame.width / 2, y:5))
//        line.addLine(to: CGPoint(x: frame.width / 3, y:10))
//        line.addLine(to: CGPoint(x: frame.width / 4, y:15))
//        line.addLine(to: CGPoint(x: frame.width / 5, y:20))
//        line.addLine(to: CGPoint(x: frame.width / 6, y:25))
        line.addLine(to: CGPoint(x: frame.width - 10, y:30))
        line.lineWidth = 2
        line.stroke()

        //Точки
        UIColor.white.setFill()

        let origins = [CGPoint(x: 10, y: 0),
                       CGPoint(x: frame.width / 6, y: 5),
                       CGPoint(x: frame.width / 3, y: 10),
                       CGPoint(x: frame.width / 2, y: 15),
                       CGPoint(x: (frame.width / 3) * 2, y: 20),
                       CGPoint(x: (frame.width / 6) * 5, y: 25),
                       CGPoint(x: frame.width - 10, y: 30),]

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
        
        let  p2 = CGPoint(x: frame.width - 10, y: 35)
        path.addLine(to: p2)

        let  dashes: [ CGFloat ] = [ 10.0, 10.0 ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineWidth = 2.0
        path.lineCapStyle = .butt
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        path.stroke()
        
    }
    
}

//MARK: -Вью для треугольника с градиентом
class TriangleView: UIView {
    
}

//MARK: -Маска для треугольника с градиентом
class MaskTriangleView: UIView {
    override func draw(_ rect: CGRect) {
        //Треугольник
        let aPath = UIBezierPath()
            aPath.move(to: CGPoint(x: 15, y: 5))
            aPath.addLine(to: CGPoint(x: 15 , y: 30))
            aPath.addLine(to: CGPoint(x: 305, y: 30))
            aPath.close()
            
            //Цвет треугольника - синий
            UIColor.white.withAlphaComponent(0.2).set()
            aPath.fill()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = aPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
        
    }
    
}

//MARK: -Линия

class LineView : UIView {
    override func draw(_ rect: CGRect) {
        //Линия
        UIColor(red: 103/255, green: 146/255, blue: 195/255, alpha: 1).set()
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 10, y:0))
//        line.addLine(to: CGPoint(x: 60, y:0))
//        line.addLine(to: CGPoint(x: 110, y:0))
//        line.addLine(to: CGPoint(x: 170, y:0))
//        line.addLine(to: CGPoint(x: 220, y:0))
//        line.addLine(to: CGPoint(x: 270, y:0))
        line.addLine(to: CGPoint(x: frame.width - 10, y:0))
        line.lineWidth = 2
        line.stroke()

        //Точки
        UIColor.white.setFill()

        let origins = [CGPoint(x: 10, y: 0),
                       CGPoint(x: frame.width / 6, y: 0),
                       CGPoint(x: frame.width / 3, y: 0),
                       CGPoint(x: frame.width / 2, y: 0),
                       CGPoint(x: (frame.width / 3) * 2, y: 0),
                       CGPoint(x: (frame.width / 6) * 5, y: 0),
                       CGPoint(x: frame.width - 10, y: 0),]

        let size = CGSize(width: 8, height: 8)

        for origin in origins {
            let quad = UIBezierPath.init(roundedRect: CGRect(origin: origin, size: size), cornerRadius: 5)
            quad.fill()
            quad.stroke()
        }
    }
}

//MARK: -Треугольник с цифрами

class TempValuesView: UIView {
    
    let viewModel: GeneralViewModel
    
    var currentIndex: Int
    
    var tempOneLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempTwoLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempThreeLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempFourLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempFiveLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempSixLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var tempSevenLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Regular", size: 16)
        tempLabel.textColor = .black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .left
        tempLabel.adjustsFontSizeToFitWidth = true
        //tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    init(frame: CGRect, viewModel: GeneralViewModel, currentIndex: Int) {
        self.viewModel = viewModel
        self.currentIndex = currentIndex
        super.init(frame: frame)
        setupViews()
        //setupConstraints()
        setTemperatureValue()
        
        tempOneLabel.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
        tempTwoLabel.frame = CGRect(x: frame.width / 6, y: 25, width: 30, height: 30)
        tempThreeLabel.frame = CGRect(x: frame.width / 3, y: 30, width: 30, height: 30)
        tempFourLabel.frame = CGRect(x: frame.width / 2, y: 35, width: 30, height: 30)
        tempFiveLabel.frame = CGRect(x: (frame.width / 3) * 2, y: 40, width: 30, height: 30)
        tempSixLabel.frame = CGRect(x: (frame.width / 6) * 5, y: 45, width: 30, height: 30)
        tempSevenLabel.frame = CGRect(x: frame.width, y: 50, width: 30, height: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(tempOneLabel)
        self.addSubview(tempTwoLabel)
        self.addSubview(tempThreeLabel)
        self.addSubview(tempFourLabel)
        self.addSubview(tempFiveLabel)
        self.addSubview(tempSixLabel)
        self.addSubview(tempSevenLabel)
    }
    
    func setupConstraints() {
        
        tempOneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        tempOneLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        tempOneLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempOneLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempTwoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        tempTwoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        tempTwoLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempTwoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempThreeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        tempThreeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 120).isActive = true
        tempThreeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempThreeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempFourLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 35).isActive = true
        tempFourLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 180).isActive = true
        tempFourLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempFourLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempFiveLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        tempFiveLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 240).isActive = true
        tempFiveLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempFiveLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempSixLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 45).isActive = true
        tempSixLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300).isActive = true
        tempSixLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempSixLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tempSevenLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        tempSevenLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        tempSevenLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempSevenLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setTemperatureValue() {
        
        if let tempOne = viewModel.weather[currentIndex].week.daily[0].temp.day {
            tempOneLabel.text = String(format: "%.0f", tempOne) + "°"
            
        }
        
        if let tempTwo = viewModel.weather[currentIndex].week.daily[1].temp.day {
            tempTwoLabel.text = String(format: "%.0f", tempTwo) + "°"
        }
        
        if let tempThree = viewModel.weather[currentIndex].week.daily[2].temp.day {
            tempThreeLabel.text = String(format: "%.0f", tempThree) + "°"
        }
        
        if let tempFour = viewModel.weather[currentIndex].week.daily[3].temp.day {
            tempFourLabel.text = String(format: "%.0f", tempFour) + "°"
        }
        
        if let tempFive = viewModel.weather[currentIndex].week.daily[4].temp.day {
            tempFiveLabel.text = String(format: "%.0f", tempFive) + "°"
        }
        
        if let tempSix = viewModel.weather[currentIndex].week.daily[5].temp.day {
            tempSixLabel.text = String(format: "%.0f", tempSix) + "°"
        }
        
        if let tempSeven = viewModel.weather[currentIndex].week.daily[6].temp.day {
            tempSevenLabel.text = String(format: "%.0f", tempSeven) + "°"
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
            if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
                if let icon = viewModel.weather[currentIndex].week.daily[indexPath.item].weather[0].icon {
                    let urlStr = "http://openweathermap.org/img/w/" + (icon) + ".png"
                        let url = URL(string: urlStr)
                        cell.imageView.kf.setImage(with: url) { result in
                            cell.setNeedsLayout()
                        }
                    }
            } else {
                if currentIndex > viewModel.weather.startIndex || currentIndex < viewModel.weather.endIndex {
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
        let humidity = viewModel.weather[currentIndex].day.list[indexPath.item].main.humidity
        cell.humidityLabel.text = "\(humidity) %"
            
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
            return CGSize(width: collectionView.frame.width / 8, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width / 8, height: collectionView.frame.height)
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

        
        let arrayTemp = viewModel.weather[currentIndex].day.list[indexPath.item].main.temp
        cell.tempLabel.text = String(format: "%.0f", arrayTemp) + "°"

        
        //MARK: -Descriptions
        cell.windDescriptionLabel.text = "Ветер"
        cell.rainDescriptionLabel.text = "Атмосферные осадки"
        cell.cloudsDescriptionLabel.text = "Облачность"
        
        //MARK: -Wind Value
        let wind = viewModel.weather[currentIndex].day.list[indexPath.item].wind.speed
        cell.windValueLabel.text = String(format: "%.0f", wind) + "m/s"
        
        //MARK: -Rain Value
        let rain = viewModel.weather[currentIndex].day.list[indexPath.item].rain?.the3H
        if rain != nil {
            cell.rainValueLabel.text = String(format: "%.0f", rain!) + "%"
        } else {
            cell.rainValueLabel.text = "?"
        }
        //MARK: -Cloud Value
        let cloud = viewModel.weather[currentIndex].day.list[indexPath.item].clouds.all
        cell.cloudsValueLabel.text = "\(cloud) %"
 
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

