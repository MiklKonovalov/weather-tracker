//
//  IconDayWeatherScreenCell.swift
//  Weather tracker
//
//  Created by Misha on 17.01.2022.
//

import Foundation
import UIKit

class IconDayWeatherScreenCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(humidityLabel)
        
        self.contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        
        let constraints = [
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            humidityLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            humidityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
