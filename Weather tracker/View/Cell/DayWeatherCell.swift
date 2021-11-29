//
//  DayWeatherCell.swift
//  Weather tracker
//
//  Created by Misha on 17.11.2021.
//

import Foundation
import UIKit

class DayWeatherCell: UICollectionViewCell, UIScrollViewDelegate {
    
    //Page View and Scroll View
    /*var data: CitiesWeather? {
        didSet {
            guard let data = data else { return }
            
                //imageView.image = data.backgroundImage
                //arcView.backgroundColor = data.color
                mainTemperatureLabel.text = String((data.main?.temp)!)
            
        }
    }*/
    
    struct Model {
        let mainTemperatureLabel: Double
        let minTemperature: Double
    }
    
    /*var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "Onboard")
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()*/
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(scrollView)
        contentView.addSubview(arcView)
        contentView.addSubview(mainTemperatureLabel)
        contentView.addSubview(minTemperatureLabel)
        
        arcView.frame = CGRect(x: contentView.frame.width / 2 - 100, y: contentView.frame.height / 2 - 100, width: 150, height: 150)
        contentView.addSubview(arcView)
                
        drawRectangle()
        
        self.contentView.layer.cornerRadius = 10
        
        let constraints = [
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            minTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            minTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        
            mainTemperatureLabel.topAnchor.constraint(equalTo: minTemperatureLabel.topAnchor, constant: 50),
            mainTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?( coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        mainTemperatureLabel.text = String(model.mainTemperatureLabel)
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
