//
//  DaeWeatherCell.swift
//  Weather tracker
//
//  Created by Misha on 18.01.2022.
//

import Foundation
import UIKit

class OneTableWeatherScreenCell: UITableViewCell {
    
    var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        dateLabel.textColor = .black
        dateLabel.lineBreakMode = .byWordWrapping
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name: "Rubik-Regular", size: 14)
        timeLabel.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        timeLabel.lineBreakMode = .byWordWrapping
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont(name: "Rubik-Medium", size: 18)
        tempLabel.textColor = UIColor.black
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment = .center
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var windImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "wind")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var rainImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "rain")
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
    
    var windDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var windValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rainValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cloudsValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(windImageView)
        contentView.addSubview(rainImageView)
        contentView.addSubview(cloudImageView)
        contentView.addSubview(windDescriptionLabel)
        contentView.addSubview(rainDescriptionLabel)
        contentView.addSubview(cloudsDescriptionLabel)
        contentView.addSubview(windValueLabel)
        contentView.addSubview(rainValueLabel)
        contentView.addSubview(cloudsValueLabel)
        
        let constraints = [
        
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.widthAnchor.constraint(equalToConstant: 70),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 30),
            timeLabel.widthAnchor.constraint(equalToConstant: 45),
            
            tempLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            tempLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: 5),
            tempLabel.heightAnchor.constraint(equalToConstant: 30),
            tempLabel.widthAnchor.constraint(equalToConstant: 30),
            
            windImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            windImageView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 10),
            windImageView.heightAnchor.constraint(equalToConstant: 20),
            windImageView.widthAnchor.constraint(equalToConstant: 20),
            
            rainImageView.topAnchor.constraint(equalTo: windImageView.bottomAnchor, constant: 10),
            rainImageView.leadingAnchor.constraint(equalTo: windImageView.leadingAnchor),
            rainImageView.heightAnchor.constraint(equalToConstant: 20),
            rainImageView.widthAnchor.constraint(equalToConstant: 20),
            
            cloudImageView.topAnchor.constraint(equalTo: rainImageView.bottomAnchor, constant: 10),
            cloudImageView.leadingAnchor.constraint(equalTo: windImageView.leadingAnchor),
            cloudImageView.heightAnchor.constraint(equalToConstant: 20),
            cloudImageView.widthAnchor.constraint(equalToConstant: 20),
            
            windDescriptionLabel.topAnchor.constraint(equalTo: windImageView.topAnchor),
            windDescriptionLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 5),
            windDescriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            windDescriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            rainDescriptionLabel.topAnchor.constraint(equalTo: rainImageView.topAnchor),
            rainDescriptionLabel.leadingAnchor.constraint(equalTo: rainImageView.trailingAnchor, constant: 5),
            rainDescriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            rainDescriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            cloudsDescriptionLabel.topAnchor.constraint(equalTo: cloudImageView.topAnchor),
            cloudsDescriptionLabel.leadingAnchor.constraint(equalTo: cloudImageView.trailingAnchor, constant: 5),
            cloudsDescriptionLabel.heightAnchor.constraint(equalToConstant: 15),
            cloudsDescriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            
            windValueLabel.topAnchor.constraint(equalTo: windImageView.topAnchor),
            windValueLabel.leadingAnchor.constraint(equalTo: windDescriptionLabel.trailingAnchor, constant: 5),
            windValueLabel.heightAnchor.constraint(equalToConstant: 15),
            windValueLabel.widthAnchor.constraint(equalToConstant: 50),
            
            rainValueLabel.topAnchor.constraint(equalTo: rainImageView.topAnchor),
            rainValueLabel.leadingAnchor.constraint(equalTo: windDescriptionLabel.trailingAnchor, constant: 5),
            rainValueLabel.heightAnchor.constraint(equalToConstant: 15),
            rainValueLabel.widthAnchor.constraint(equalToConstant: 50),
            
            cloudsValueLabel.topAnchor.constraint(equalTo: cloudsDescriptionLabel.topAnchor),
            cloudsValueLabel.leadingAnchor.constraint(equalTo: cloudsDescriptionLabel.trailingAnchor, constant: 5),
            cloudsValueLabel.heightAnchor.constraint(equalToConstant: 15),
            cloudsValueLabel.widthAnchor.constraint(equalToConstant: 50),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
