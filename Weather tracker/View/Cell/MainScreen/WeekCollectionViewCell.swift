//
//  BottomCollectionViewCell.swift
//  Weather tracker
//
//  Created by Misha on 22.11.2021.
//

import UIKit

class WeekCollectionViewCell: UICollectionViewCell {
    
    var dateTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherImageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var rainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 12)
        label.textColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.masksToBounds = false
        
        contentView.addSubview(dateTemperatureLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(rainLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(maxTemperatureLabel)
        contentView.addSubview(arrowImageView)
        
        
        
        
        let constraints = [
        
            dateTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            weatherImageView.topAnchor.constraint(equalTo: dateTemperatureLabel.bottomAnchor, constant: 5),
            weatherImageView.leadingAnchor.constraint(equalTo: dateTemperatureLabel.leadingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 20),
            weatherImageView.widthAnchor.constraint(equalToConstant: 20),
            
            rainLabel.topAnchor.constraint(equalTo: dateTemperatureLabel.bottomAnchor, constant: 1),
            rainLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 1),
            //rainLabel.widthAnchor.constraint(equalToConstant: 5),
            //rainLabel.heightAnchor.constraint(equalToConstant: 5),
            
            weatherDescriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            minTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: minTemperatureLabel.trailingAnchor, constant: 0),
            
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
