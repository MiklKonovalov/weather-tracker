//
//  TodayCollectionViewCell.swift
//  Weather tracker
//
//  Created by Misha on 22.11.2021.
//

import UIKit

class TwentyFourHoursCollectionViewCell: UICollectionViewCell {
    
    var mainTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Medium", size: 12)
        label.textColor = UIColor(red: 0.613, green: 0.592, blue: 0.592, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var cellBorderView: UILabel = {
        let view = UILabel()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        return view
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mainTemperatureLabel)
        contentView.addSubview(cellBorderView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(imageView)
    
        
        let constraints = [
            
            mainTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainTemperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainTemperatureLabel.heightAnchor.constraint(equalToConstant: 40),
            mainTemperatureLabel.widthAnchor.constraint(equalToConstant: 40),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        
            cellBorderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellBorderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellBorderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?( coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
