//
//  DayWeatherCell.swift
//  Weather tracker
//
//  Created by Misha on 17.11.2021.
//

import Foundation
import UIKit

class DayWeatherCell: UICollectionViewCell, UIScrollViewDelegate {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    let shapeLayer = CAShapeLayer()
    
    var arcView: UIView = {
        let arc = UIView()
        arc.backgroundColor = .clear
        arc.translatesAutoresizingMaskIntoConstraints = false
        return arc
    }()
    
    var mainTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 36)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var slash: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.text = "/"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunrise: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunset: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sunriseImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "sunrise")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var sunsetImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "sunset")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var cloudImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "cloud")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var windImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "wind")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var humidityImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "humidity")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(scrollView)
        contentView.addSubview(arcView)
        contentView.addSubview(mainTemperatureLabel)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(slash)
        contentView.addSubview(maxTemperatureLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(cloudsLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(sunrise)
        contentView.addSubview(sunset)
        contentView.addSubview(dateLabel)
        contentView.addSubview(sunriseImageView)
        contentView.addSubview(sunsetImageView)
        contentView.addSubview(cloudImageView)
        contentView.addSubview(windImageView)
        contentView.addSubview(humidityImageView)
        
        contentView.addSubview(arcView)
                
        drawRectangle()
        
        self.contentView.layer.cornerRadius = 10
        
        let constraints = [
            
            arcView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            arcView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -100),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            minTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -20),
            
            slash.topAnchor.constraint(equalTo: minTemperatureLabel.topAnchor, constant: 0),
            slash.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 10),
            
            maxTemperatureLabel.topAnchor.constraint(equalTo: minTemperatureLabel.topAnchor, constant: 0),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: slash.trailingAnchor, constant: 10),
        
            mainTemperatureLabel.topAnchor.constraint(equalTo: minTemperatureLabel.topAnchor, constant: 30),
            mainTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: mainTemperatureLabel.topAnchor, constant: 30),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            windSpeedLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.topAnchor, constant: 30),
            windSpeedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            windImageView.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor, constant: 0),
            windImageView.trailingAnchor.constraint(equalTo: windSpeedLabel.leadingAnchor, constant: -5),
            windImageView.heightAnchor.constraint(equalToConstant: 20),
            windImageView.widthAnchor.constraint(equalToConstant: 20),
            
            cloudsLabel.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor, constant: 0),
            cloudsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -80),
            
            cloudImageView.topAnchor.constraint(equalTo: cloudsLabel.topAnchor, constant: 0),
            cloudImageView.trailingAnchor.constraint(equalTo: cloudsLabel.leadingAnchor, constant: -5),
            cloudImageView.heightAnchor.constraint(equalToConstant: 20),
            cloudImageView.widthAnchor.constraint(equalToConstant: 20),
            
            humidityLabel.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor, constant: 0),
            humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 80),
            
            humidityImageView.topAnchor.constraint(equalTo: humidityLabel.topAnchor, constant: 0),
            humidityImageView.trailingAnchor.constraint(equalTo: humidityLabel.leadingAnchor, constant: -5),
            humidityImageView.heightAnchor.constraint(equalToConstant: 20),
            humidityImageView.widthAnchor.constraint(equalToConstant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: windSpeedLabel.topAnchor, constant: 40),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            sunriseImageView.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            sunriseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sunriseImageView.heightAnchor.constraint(equalToConstant: 30),
            sunriseImageView.widthAnchor.constraint(equalToConstant: 30),
            
            sunsetImageView.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            sunsetImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sunsetImageView.heightAnchor.constraint(equalToConstant: 30),
            sunsetImageView.widthAnchor.constraint(equalToConstant: 30),
            
            sunrise.topAnchor.constraint(equalTo: sunriseImageView.bottomAnchor, constant: 10),
            sunrise.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            sunset.topAnchor.constraint(equalTo: sunsetImageView.bottomAnchor, constant: 10),
            sunset.trailingAnchor.constraint(equalTo: sunsetImageView.trailingAnchor, constant: 0),
            
 
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?( coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawRectangle() {
            
            let path = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: 100, startAngle: 0, endAngle: .pi, clockwise: false)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.yellow.cgColor
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 3
            
            arcView.layer.addSublayer(shapeLayer)
        }
    
}
