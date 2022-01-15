//
//  DayCityWeatherViewController.swift
//  Weather tracker
//
//  Created by Misha on 17.11.2021.
//

import Foundation
import UIKit

class DayCityWeatherViewController: UIViewController {
    
    //MARK: -Properties
    
    let viewModel: GeneralViewModel
    
    let locationViewModel = LocationViewModel(
        locationService: LocationManager(),
        locationGroup: LocationGroup())
    
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
    
    //BluewView
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
        diagonalView.backgroundColor = .clear
        diagonalView.translatesAutoresizingMaskIntoConstraints = false
        return diagonalView
    }()
    
    //MARK: -Selectors
    
    @objc func arrowButtonTap() {
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(arrowButton)
        view.addSubview(titleLabel)
        view.addSubview(cityLabel)
        view.addSubview(blueView)
        
        setupConstraints()
        
        cityLabel.text = viewModel.weather[currentIndex].now.name
        
        let diagonalView = DiagonalView(frame: CGRect(x: 30, y: 150, width: 400, height: 100))
        self.view.addSubview(diagonalView)
        diagonalView.backgroundColor = UIColor.white
        //(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    }
    
    //MARK: -Functions
    
    func setupConstraints() {
        
        let constraints = [
        
            arrowButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 41),
            arrowButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            arrowButton.widthAnchor.constraint(equalToConstant: 15),
            arrowButton.heightAnchor.constraint(equalToConstant: 12),
            
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
            
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

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
    }
  }



